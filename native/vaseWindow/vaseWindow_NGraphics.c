#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#define GLFW_INCLUDE_NONE
#include "GLFW/glfw3.h"

#include "nanovg.h"

#include <math.h>

#define MIN(a, b)  ((a) < (b) ? (a) : (b))
#define PI 3.14159265358979323846

NVGcontext * vaseWindow_NGraphics_geNvgContext(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (NVGcontext**)(val.i);
}

void vaseWindow_NGraphics_setNvgContext(fr_Env env, fr_Obj self, NVGcontext* r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

void vaseWindow_NGraphics_setColor(fr_Env env, fr_Obj self, fr_Int a, fr_Int r, fr_Int g, fr_Int b) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    NVGcolor color = nvgRGBA(r, g, b, a);
    nvgStrokeColor(vg, color);
    nvgFillColor(vg, color);
}
void vaseWindow_NGraphics_setPattern(fr_Env env, fr_Obj self, fr_Obj pattern) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    return;
}
void vaseWindow_NGraphics_setGradient(fr_Env env, fr_Obj self, fr_Obj gradient) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    return;
}
void vaseWindow_NGraphics_setPen(fr_Env env, fr_Obj self, fr_Int width, fr_Int cap, fr_Int join, fr_Obj dash) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);

    nvgStrokeWidth(vg, width);
    nvgLineCap(vg, cap);
    nvgLineJoin(vg, join);

    return;
}
void vaseWindow_NGraphics_setFont(fr_Env env, fr_Obj self, fr_Obj font, fr_Int id, fr_Obj name, fr_Int size, fr_Int blur) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    return;
}
void vaseWindow_NGraphics_setAntialias(fr_Env env, fr_Obj self, fr_Bool antialias) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgShapeAntiAlias(vg, antialias);
    return;
}
void vaseWindow_NGraphics_setAlpha(fr_Env env, fr_Obj self, fr_Int alpha) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgGlobalAlpha(vg, alpha / 255.0);
    return;
}
void vaseWindow_NGraphics_setComposite(fr_Env env, fr_Obj self, fr_Int composite) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    return;
}

fr_Obj vaseWindow_NGraphics_drawLine(fr_Env env, fr_Obj self, fr_Int x1, fr_Int y1, fr_Int x2, fr_Int y2) {
    NVGcontext *vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgMoveTo(vg, x1 + 0.5, y1 + 0.5);
    nvgLineTo(vg, x2 + 0.5, y2 + 0.5);
    nvgClosePath(vg);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawPolyline(fr_Env env, fr_Obj self, fr_Obj ps) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    fr_Int size = fr_callOnObj(env, ps, "size", 0).i;
    double x;
    double y;
    fr_Type ptype = fr_getObjType(env, ps);
    fr_Method getXM = fr_findMethod(env, ptype, "getX");
    fr_Method getYM = fr_findMethod(env, ptype, "getY");
    for (int i = 0; i < size; i++)
    {
        x = fr_callMethod(env, getXM, 1, ps).i;
        y = fr_callMethod(env, getYM, 1, ps).i;
        if (i == 0) nvgMoveTo(vg, x, y);
        else nvgLineTo(vg, x, y);
    }
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawPolygon(fr_Env env, fr_Obj self, fr_Obj ps) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    fr_Int size = fr_callOnObj(env, ps, "size", 0).i;
    double x;
    double y;
    fr_Type ptype = fr_getObjType(env, ps);
    fr_Method getXM = fr_findMethod(env, ptype, "getX");
    fr_Method getYM = fr_findMethod(env, ptype, "getY");
    for (int i = 0; i < size; i++)
    {
        x = fr_callMethod(env, getXM, 1, ps).i;
        y = fr_callMethod(env, getYM, 1, ps).i;
        if (i == 0) nvgMoveTo(vg, x, y);
        else nvgLineTo(vg, x, y);
    }
    nvgClosePath(vg);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillPolygon(fr_Env env, fr_Obj self, fr_Obj ps) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    fr_Int size = fr_callOnObj(env, ps, "size", 0).i;
    double x;
    double y;
    fr_Type ptype = fr_getObjType(env, ps);
    fr_Method getXM = fr_findMethod(env, ptype, "getX");
    fr_Method getYM = fr_findMethod(env, ptype, "getY");
    for (int i = 0; i < size; i++)
    {
        x = fr_callMethod(env, getXM, 1, ps).i;
        y = fr_callMethod(env, getYM, 1, ps).i;
        if (i == 0) nvgMoveTo(vg, x, y);
        else nvgLineTo(vg, x, y);
    }
    nvgClosePath(vg);
    nvgFill(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgRect(vg, x, y, w, h);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgRect(vg, x, y, w, h);
    nvgFill(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_clearRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgSave(vg);
    nvgScissor(vg, x, y, w, h);

    nvgBeginPath(vg);
    nvgRect(vg, x, y, w, h);
    nvgFill(vg);

    nvgRestore(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgRoundedRect(vg, x, y, w, h, wArc);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgRoundedRect(vg, x, y, w, h, wArc);
    nvgFill(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgEllipse(vg, x + w / 2.0, y + h / 2.0, w, h);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    nvgEllipse(vg, x + w / 2.0, y + h / 2.0, w, h);
    nvgFill(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);
    double cx = x + (w / 2.0);
    double cy = y + (h / 2.0);
    double rad = MIN(w / 2.0, h / 2.0);
    double sa = PI / 180 * startAngle;
    double ea = PI / 180 * (startAngle + arcAngle);

    nvgArc(vg, cx, cy, rad, -sa, -ea, NVG_CCW);
    nvgStroke(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgBeginPath(vg);

    double cx = x + (w / 2.0);
    double cy = y + (h / 2.0);
    double radius = MIN(w / 2.0, h / 2.0);

    double startRads = PI / 180.0 * startAngle;
    double x1 = cx + (cos(-startRads) * radius);
    double y1 = cy + (sin(-startRads) * radius);

    double endRads = PI / 180.0 * (startAngle + arcAngle);
    double x2 = cx + (cos(-endRads) * radius);
    double y2 = cy + (sin(-endRads) * radius);

    nvgMoveTo(vg, cx, cy);
    nvgLineTo(vg, x1, y1);
    nvgArc(vg, cx, cy, radius, -startRads, -endRads, NVG_CCW);
    nvgLineTo(vg, x2, y2);
    nvgClosePath(vg);
    nvgFill(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawText(fr_Env env, fr_Obj self, fr_Obj s, fr_Int x, fr_Int y) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    const char* str = fr_getStrUtf8(env, s);
    nvgText(vg, x, y, str, NULL);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawImage(fr_Env env, fr_Obj self, fr_Obj image, fr_Int x, fr_Int y) {
    return 0;
}
fr_Obj vaseWindow_NGraphics_copyImage(fr_Env env, fr_Obj self, fr_Obj image, fr_Obj src, fr_Obj dest) {
    return 0;
}
void vaseWindow_NGraphics_doClip(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgScissor(vg, x, y, w, h);
}
void vaseWindow_NGraphics_pushNative(fr_Env env, fr_Obj self) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgSave(vg);
}
void vaseWindow_NGraphics_popNative(fr_Env env, fr_Obj self) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgRestore(vg);
}
void vaseWindow_NGraphics_dispose(fr_Env env, fr_Obj self) {
    //vaseWindow_NGraphics_setNvgContext(env, self, NULL);
    return;
}
fr_Obj vaseWindow_NGraphics_drawPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
fr_Obj vaseWindow_NGraphics_fillPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
void vaseWindow_NGraphics_doTransform(fr_Env env, fr_Obj self, fr_Float a, fr_Float b, fr_Float c, fr_Float d, fr_Float e, fr_Float f) {
    NVGcontext* vg = vaseWindow_NGraphics_geNvgContext(env, self);
    nvgTransform(vg, a, b, c, d, e, f);
}
fr_Obj vaseWindow_NGraphics_clipPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
fr_Obj vaseWindow_NGraphics_setShadow(fr_Env env, fr_Obj self, fr_Obj shadow) {
    return 0;
}
