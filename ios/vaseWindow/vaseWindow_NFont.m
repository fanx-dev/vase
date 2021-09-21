#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <CoreGraphics/CoreGraphics.h>

fr_Int vaseWindow_NFont_getHandle(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.i);
}

void vaseWindow_NFont_setHandle(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

void vaseWindow_NFont_dispose(fr_Env env, fr_Obj self) {
    return;
}
fr_Int vaseWindow_NFont_ascent(fr_Env env, fr_Obj self) {
    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
    return CGFontGetAscent(font);
}
fr_Int vaseWindow_NFont_descent(fr_Env env, fr_Obj self) {
    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
    return CGFontGetDescent(font);
}
fr_Int vaseWindow_NFont_height(fr_Env env, fr_Obj self) {
    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
    return CGFontGetLeading(font) + CGFontGetAscent(font) + CGFontGetDescent(font);
}
fr_Int vaseWindow_NFont_width(fr_Env env, fr_Obj self, fr_Obj s) {
    //TODO
    return 0;
}
