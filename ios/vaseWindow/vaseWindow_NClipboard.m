#include "fni_ext.h"
#include "pod_vaseWindow_native.h"
#import <UIKit/UIKit.h>

fr_Obj vaseWindow_NClipboard_getTextSync(fr_Env env, fr_Obj self) {
    NSString *latest = [UIPasteboard generalPasteboard].string;
    return fr_newStrUtf8(env, latest.UTF8String);
}
void vaseWindow_NClipboard_setText(fr_Env env, fr_Obj self, fr_Obj data) {
    if (!fr_isInstanceOf(env, data, fr_findType(env, "sys", "Str"))) {
        fr_throwUnsupported(env);
        return;
    }
    const char *str = fr_getStrUtf8(env, data);
    NSString *text = [NSString stringWithUTF8String:str];
    [[UIPasteboard generalPasteboard] setString:text];
}
