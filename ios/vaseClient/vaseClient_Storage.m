#include "fni_ext.h"
#include "pod_vaseClient_native.h"

#import <UIKit/UIKit.h>

fr_Obj vaseClient_Storage_instance = NULL;

fr_Obj vaseClient_Storage_cur(fr_Env env) {
    if (vaseClient_Storage_instance == NULL) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFilePath = paths.firstObject;
        documentFilePath = [documentFilePath stringByAppendingString:@"/defaultStorage/"];
        fr_Obj path = fr_newStrUtf8(env, documentFilePath.UTF8String);
        
        fr_Obj starage = fr_newObjS(env, "vaseClient", "FileStorage", "make", 1, path);
        vaseClient_Storage_instance = fr_newGlobalRef(env, starage);
    }
    return vaseClient_Storage_instance;
}
