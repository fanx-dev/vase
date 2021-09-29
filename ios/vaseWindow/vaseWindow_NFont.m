#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

extern float desityScale;

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
    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
    if (font == NULL) return;
    CGFontRelease(font);
    vaseWindow_NFont_setHandle(env, self, 0);
    return;
}
fr_Int vaseWindow_NFont_ascent(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    return CGFontGetAscent(font);
    fr_Int size = fr_getFieldS(env, self, "size").i  ;
    UIFont *uifont = [UIFont systemFontOfSize:size];
    int h = uifont.ascender;
    return h;
}
fr_Int vaseWindow_NFont_descent(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    return CGFontGetDescent(font);
    fr_Int size = fr_getFieldS(env, self, "size").i  ;
    UIFont *uifont = [UIFont systemFontOfSize:size];
    int h = -uifont.descender;
    return h;
}
fr_Int vaseWindow_NFont_leading(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    int height = CGFontGetLeading(font) + CGFontGetAscent(font) + CGFontGetDescent(font);
//    return height;
    fr_Int size = fr_getFieldS(env, self, "size").i  ;
    UIFont *uifont = [UIFont systemFontOfSize:size];
    int h = uifont.leading;
    return h;
}
fr_Int vaseWindow_NFont_width(fr_Env env, fr_Obj self, fr_Obj s) {
    const char* str = fr_getStrUtf8(env, s);
    NSString *nsstr = [NSString stringWithUTF8String: str];
    fr_Int size = fr_getFieldS(env, self, "size").i  ;
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size], NSFontAttributeName, nil, nil];
    CGSize tsize = [nsstr sizeWithAttributes:attrs];
    return tsize.width;
}
void vaseWindow_NFont_finalize(fr_Env env, fr_Obj self) {
    vaseWindow_NFont_dispose(env, self);
    return;
}

