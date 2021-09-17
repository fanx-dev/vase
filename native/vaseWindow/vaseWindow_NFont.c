#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#include "nanovg.h"

extern NVGcontext* g_nanovg;

void vaseWindow_NFont_dispose(fr_Env env, fr_Obj self) {
    return;
}
fr_Int vaseWindow_NFont_ascent(fr_Env env, fr_Obj self) {
    float ascender; float descender; float lineh;
    nvgTextMetrics(g_nanovg, &ascender, &descender, &lineh);
    return ascender;
}
fr_Int vaseWindow_NFont_descent(fr_Env env, fr_Obj self) {
    float ascender; float descender; float lineh;
    nvgTextMetrics(g_nanovg, &ascender, &descender, &lineh);
    return descender;
}
fr_Int vaseWindow_NFont_height(fr_Env env, fr_Obj self) {
    float ascender; float descender; float lineh;
    nvgTextMetrics(g_nanovg, &ascender, &descender, &lineh);
    return lineh;
}
fr_Int vaseWindow_NFont_width(fr_Env env, fr_Obj self, fr_Obj s) {
    float bounds[4];//[xmin,ymin, xmax,ymax]
    nvgTextBounds(g_nanovg, 0, 0, fr_getStrUtf8(env, s), NULL, bounds);
    int width = bounds[2] - bounds[0];
    return width;
}
