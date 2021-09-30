#include "fni_ext.h"
#include "pod_vaseClient_native.h"

#import <UIKit/UIKit.h>


fr_Obj makeRes(fr_Env env, fr_Obj self, NSData *data, NSURLResponse *response, NSError *error) {
    fr_Obj res = fr_newObjS(env, "vaseClient", "HttpRes", "make", 0);
    
    NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*)response;
    NSInteger status = httpRes.statusCode;
    
    NSDictionary *headers = httpRes.allHeaderFields;
    fr_Obj map = fr_getFieldS(env, res, "headers").h;
    fr_Method setM = fr_findMethod(env, fr_findType(env, "std", "Map"), "set");
    for (NSObject *k in headers) {
        NSObject *v = headers[k];
        fr_Obj fk = fr_newStrUtf8(env, ((NSString*)k).UTF8String);
        fr_Obj fv = fr_newStrUtf8(env, ((NSString*)v).UTF8String);
        fr_callMethod(env, setM, 3, map, fk, fv);
    }
    
    fr_Obj content = NULL;
    fr_Obj decoder = fr_getFieldS(env, self, "decoder").h;
    if (decoder == NULL) {
        NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        content = fr_newStrUtf8(env, str.UTF8String);
    }
    else {
        fr_Obj array = fr_arrayNew(env, fr_findType(env, "sys", "Int"), 1, data.length);
        memcpy(fr_arrayData(env, array), data.bytes, data.length);
        fr_Obj buf = fr_newObjS(env, "std", "MemBuf", "makeBuf", 1, array);
        fr_Obj inStream = fr_callOnObj(env, buf, "in", 0).h;
        fr_Obj decodeRes = fr_callOnObj(env, decoder, "call", 1, inStream).h;
        content = decodeRes;
    }
    fr_Value value;
    value.i = status;
    fr_setFieldS(env, res, "status", value);
    value.h = content;
    fr_setFieldS(env, res, "content", value);
    
    return res;
}

void writeMultiPart(fr_Env env, fr_Obj self, fr_Obj content, NSMutableURLRequest *request) {
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postData = [[NSMutableData alloc]init];//请求体数据
    fr_Obj keys = fr_callOnObj(env, content, "keys", 0).h;
    int size = (int)fr_callOnObj(env, keys, "size", 0).i;
    fr_Type fileType = fr_findType(env, "std", "File");
    //fr_printObj(env, content);
    //fr_printObj(env, keys);
    for (int i=0; i<size; ++i) {
        fr_Obj key = fr_callOnObj(env, keys, "get", 1, (fr_Int)i).h;
        fr_Obj val = fr_callOnObj(env, content, "get", 1, key).h;
        const char *keyStr = fr_getStrUtf8(env, key);

        if (fr_isInstanceOf(env, val, fileType)) {
            NSString *path = [NSString stringWithUTF8String: fr_getStrUtf8(env, fr_callOnObj(env, val, "osPath", 0).h)];
            NSData *fileData = [NSData dataWithContentsOfFile:path];
            
            NSString *filename = [path lastPathComponent];
            NSString *contentType = @"application/octet-stream";
            
            NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%s\"; filename=\"%@\"Content-Type=%@\r\n\r\n",boundary,keyStr,filename,contentType];
            [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
            [postData appendData:fileData];
        }
        else {
            NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%s\"\r\n\r\n",boundary,keyStr];
            [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
            
            [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
            fr_Obj strObj = fr_callOnObj(env, val, "toStr", 0).h;
            const char *str = fr_getStrUtf8(env, strObj);
            [postData appendData: [[NSString stringWithUTF8String:str] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = postData;
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
}

fr_Obj vaseClient_HttpReq_send(fr_Env env, fr_Obj self, fr_Obj method, fr_Obj content) {
    const char *methodStr = fr_getStrUtf8(env, method);
    
    bool isPost = (strcmp("GET", methodStr) != 0);
    
    fr_Obj uri = fr_callOnObj(env, fr_getFieldS(env, self, "uri").h, "toStr", 0).h;
    const char *uriStr = fr_getStrUtf8(env, uri);
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithUTF8String:uriStr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:[NSString stringWithUTF8String:methodStr]];
    
    if (isPost && content) {
        fr_Type fileType = fr_findType(env, "std", "File");
        fr_Type mapType = fr_findType(env, "std", "Map");
        if (fr_isInstanceOf(env, content, fileType)) {
            if ([request valueForHTTPHeaderField:@"Content-Type"] == nil) [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
            NSString *path = [NSString stringWithUTF8String: fr_getStrUtf8(env, fr_callOnObj(env, content, "osPath", 0).h)];
            NSData *data = [NSData dataWithContentsOfFile:path];
            request.HTTPBody = data;
        }
        else if (fr_isInstanceOf(env, content, mapType)) {
            writeMultiPart(env, self, content, request);
        }
        else {
            if ([request valueForHTTPHeaderField:@"Content-Type"] == nil) [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
            fr_Obj strObj = fr_callOnObj(env, content, "toStr", 0).h;
            const char *str = fr_getStrUtf8(env, strObj);
            request.HTTPBody = [[NSString stringWithUTF8String:str] dataUsingEncoding:NSUTF8StringEncoding];
        }
    }

    fr_Obj promise = fr_callMethodS(env, "concurrent", "Promise", "make", 0).h;
    promise = fr_newGlobalRef(env, promise);
    fr_Obj reqObj = fr_newGlobalRef(env, self);

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
          fr_Obj err = fr_newObjS(env, "sys", "IOErr", "make", 1, fr_newStrUtf8(env, "http request error"));
          fr_callOnObj(env, promise, "complete", 2, err, false);
        }
        else {
          fr_Obj res = makeRes(env, reqObj, data, response, error);
          fr_callOnObj(env, promise, "complete", 2, res, true);
        }
        fr_deleteGlobalRef(env, promise);
        fr_deleteGlobalRef(env, reqObj);
    }];
    [task resume];
    
    return 0;
}
