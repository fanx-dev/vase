#import "HZIAPManager.h"
#import <Foundation/Foundation.h>

#include "fni_ext.h"
#include "pod_vaseClient_native.h"

void vaseClient_Purchase_finish(fr_Env env, fr_Obj self, fr_Obj name, fr_Int res);

HZIAPManager *iapMgr = nil;

fr_Bool vaseClient_Purchase_start(fr_Env env, fr_Obj self, fr_Obj name, fr_Int ttype) {
    
    iapMgr = [[HZIAPManager alloc] init];
    
    fr_Obj selfObj = fr_newGlobalRef(env, self);
    fr_Obj nameObj = fr_newGlobalRef(env, name);
    
    const char *nameStr = fr_getStrUtf8(env, name);
    
    [iapMgr startWithProductID:[NSString stringWithUTF8String:nameStr] type:(int)ttype completeHandle:^(IAPResultType type, NSData * _Nonnull data) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            fr_Env env = fr_getEnv(NULL, NULL);
            if (type == IAPResultSuccess || type == IAPResultVerSuccess) {
                vaseClient_Purchase_finish(env, selfObj, nameObj, 1);
            }
            else {
                vaseClient_Purchase_finish(env, selfObj, nameObj, 0);
            }
            fr_deleteGlobalRef(env, selfObj);
            fr_deleteGlobalRef(env, nameObj);
            
        });
    }];

    return true;
}
