#include "fni_ext.h"
#include "pod_vaseWindow_native.h"
#import <UIKit/UIKit.h>

fr_Obj vaseWindow_NToolkit_curWindow = NULL;

extern float desityScale;

void vaseAndroid_AndroidEnv_dummy(fr_Env __env) { }

fr_Obj vaseWindow_NToolkit_window(fr_Env env, fr_Obj self, fr_Obj view, fr_Obj options) {
    if (view) {
        fr_Obj win = fr_newObjS(env, "vaseWindow", "NWindow", "make", 1, view);
        if (vaseWindow_NToolkit_curWindow) fr_deleteGlobalRef(env, vaseWindow_NToolkit_curWindow);
        vaseWindow_NToolkit_curWindow = fr_newGlobalRef(env, win);
        fr_callOnObj(env, win, "show", 1, NULL);
    }
    return vaseWindow_NToolkit_curWindow;
}
void vaseWindow_NToolkit_callLater(fr_Env env, fr_Obj self, fr_Int delay, fr_Obj f) {
    static fr_Method callM;
    if (callM == NULL) {
        callM = fr_findMethodN(env, fr_findType(env, "sys", "Func"), "call", 0);
    }
    
    fr_Obj callback = fr_newGlobalRef(env, f);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_MSEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        fr_Env env = fr_getEnv(NULL);
        fr_callMethod(env, callM, 1, callback);
        fr_deleteGlobalRef(env, callback);
    });
    return;
}
fr_Float vaseWindow_NToolkit_density(fr_Env env, fr_Obj self) {
    return desityScale * 0.5;
}
fr_Bool vaseWindow_NToolkit_openUri(fr_Env env, fr_Obj self, fr_Obj uri, fr_Obj options) {
    const char *str = fr_getStrUtf8(env, uri);
    NSString *nstr = [NSString stringWithUTF8String:str];
    NSURL *url = [NSURL URLWithString:nstr];
    [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    return true;
}
fr_Obj vaseWindow_NToolkit_resFilePath(fr_Env env, fr_Obj self, fr_Obj pod, fr_Obj uri) {
    const char *podStr = fr_getStrUtf8(env, pod);
    const char *uriStr = fr_getStrUtf8(env, uri);
    
    NSString *resPath = [NSBundle.mainBundle resourcePath];
    NSString *path;
    if (strlen(podStr) > 0) {
        path = [NSString stringWithFormat:@"%@/res/%s/%s", resPath, podStr, uriStr];
    }
    else {
        path = [NSString stringWithFormat:@"%@/res/%s", resPath, uriStr];
    }
    const char * resStr = path.UTF8String;
    return fr_newStrUtf8(env, resStr);
}
