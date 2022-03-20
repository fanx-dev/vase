#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <UIKit/UIKit.h>

extern float desityScale;
fr_Obj vaseWindow_Toolkit_instance = NULL;

fr_Obj vaseWindow_Toolkit_cur(fr_Env env) {
    if (vaseWindow_Toolkit_instance == NULL) {
        fr_Obj obj = fr_newObjS(env, "vaseWindow", "NToolkit", "make", 0);
        fr_callOnObj(env, obj, "onInit", 0);
        vaseWindow_Toolkit_instance = fr_newGlobalRef(env, obj);
        
        desityScale = [[UIScreen mainScreen] scale];
    }
    return vaseWindow_Toolkit_instance;
}

