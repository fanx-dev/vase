#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

fr_Obj vaseWindow_NToolkit_curWindow = NULL;

void run() {

}

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
    return;
}
fr_Int vaseWindow_NToolkit_dpi(fr_Env env, fr_Obj self) {
    return 90;
}
fr_Bool vaseWindow_NToolkit_openUri(fr_Env env, fr_Obj self, fr_Obj uri, fr_Obj options) {
    return 0;
}
