#include "fni_ext.h"
#include "pod_vaseWindow_native.h"
#import <UIKit/UIKit.h>

fr_Obj vaseWindow_NToolkit_curWindow = NULL;

extern float desityScale;

fr_Obj vaseWindow_NToolkit_window(fr_Env env, fr_Obj self, fr_Obj view) {
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
        callM = fr_findMethod(env, fr_getObjType(env, f), "call");
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_MSEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        fr_callMethod(env, callM, 1, f);
    });
    return;
}
fr_Int vaseWindow_NToolkit_dpi(fr_Env env, fr_Obj self) {
    return 320 * desityScale;
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
        path = [NSString stringWithFormat:@"%@/%s/%s", resPath, podStr, uriStr];
    }
    else {
        path = [NSString stringWithFormat:@"%@/%s", resPath, uriStr];
    }
    const char * resStr = path.UTF8String;
    return fr_newStrUtf8(env, resStr);
}