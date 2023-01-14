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

void vaseWindow_NFont_finalize(fr_Env env, fr_Obj self);

void vaseWindow_NFont_setHandle(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
    
    fr_Type type = fr_getObjType(env, self);
    fr_registerDestructor(env, type, vaseWindow_NFont_finalize);
}

void vaseWindow_NFont_dispose(fr_Env env, fr_Obj self) {
    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
    if (font == NULL) return;
    CGFontRelease(font);
    vaseWindow_NFont_setHandle(env, self, 0);
    return;
}
UIFont *vaseWindow_NFont_font(fr_Env env, fr_Obj self) {
    static fr_Field sizeF;
    static fr_Field boldF;
    static fr_Field italicF;
    static fr_Field nameF;
    if (!sizeF) {
        fr_Type type = fr_getObjType(env, self);
        sizeF = fr_findField(env, type, "size");
        boldF = fr_findField(env, type, "bold");
        italicF = fr_findField(env, type, "italic");
        nameF = fr_findField(env, type, "name");
    }
    
    fr_Value size;
    fr_getInstanceField(env, self, sizeF, &size);
    
    fr_Value bold;
    fr_getInstanceField(env, self, boldF, &bold);
    
    fr_Value italic;
    fr_getInstanceField(env, self, italicF, &italic);
    
    fr_Value name;
    fr_getInstanceField(env, self, nameF, &name);
    
    const char *cname = fr_getStrUtf8(env, name.h);
    if (strcmp(cname, "slideyouran-Regular") == 0) {
       return [UIFont fontWithDescriptor:[UIFontDescriptor fontDescriptorWithName:[NSString stringWithUTF8String:cname] size:size.i] size:size.i];
    }
    
    UIFont *uifont;
    if (bold.b) {
        uifont = [UIFont boldSystemFontOfSize:size.i];
    }
    else if (italic.b) {
        uifont = [UIFont italicSystemFontOfSize:size.i];
    }
    else {
        uifont = [UIFont systemFontOfSize:size.i];
    }
    return uifont;
}

fr_Int vaseWindow_NFont_ascent(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    return CGFontGetAscent(font);
    UIFont *uifont = vaseWindow_NFont_font(env, self);
    int h = uifont.ascender;
    return h;
}
fr_Int vaseWindow_NFont_descent(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    return CGFontGetDescent(font);
    UIFont *uifont = vaseWindow_NFont_font(env, self);
    int h = -uifont.descender;
    return h;
}
fr_Int vaseWindow_NFont_leading(fr_Env env, fr_Obj self) {
//    CGFontRef font = (CGFontRef)vaseWindow_NFont_getHandle(env, self);
//    int height = CGFontGetLeading(font) + CGFontGetAscent(font) + CGFontGetDescent(font);
//    return height;
    UIFont *uifont = vaseWindow_NFont_font(env, self);
    int h = uifont.leading;
    return h;
}
fr_Int vaseWindow_NFont_width(fr_Env env, fr_Obj self, fr_Obj s) {
    const char* str = fr_getStrUtf8(env, s);
    NSString *nsstr = [NSString stringWithUTF8String: str];
    UIFont *uifont = vaseWindow_NFont_font(env, self);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:uifont, NSFontAttributeName, nil, nil];
    CGSize tsize = [nsstr sizeWithAttributes:attrs];
    return tsize.width;
}
void vaseWindow_NFont_finalize(fr_Env env, fr_Obj self) {
    vaseWindow_NFont_dispose(env, self);
    return;
}

