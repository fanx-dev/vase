#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#include <math.h>
#include <string.h>

#define MIN(a, b)  ((a) < (b) ? (a) : (b))
#define PI 3.14159265358979323846
extern float desityScale;

void vaseWindow_NImage_endGraphics(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NImage_getHandle(fr_Env env, fr_Obj self);
void vaseWindow_NImage_setHandle(fr_Env env, fr_Obj self, fr_Int r);
void vaseWindow_NImage_getSize(fr_Env env, fr_Obj self, int* w, int* h);
char* vaseWindow_NImage_getData(fr_Env env, fr_Obj self);
fr_Int vaseWindow_NImage_getFlags(fr_Env env, fr_Obj self);

fr_Int vaseWindow_NGraphics_getContext(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.i);
}

void vaseWindow_NGraphics_setContext(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

//fr_Int vaseWindow_NGraphics_getSurface(fr_Env env, fr_Obj self) {
//    static fr_Field f = NULL;
//    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "surface");
//    fr_Value val;
//    fr_getInstanceField(env, self, f, &val);
//    return (val.i);
//}
//
//void vaseWindow_NGraphics_setSurface(fr_Env env, fr_Obj self, fr_Int r) {
//    static fr_Field f = NULL;
//    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "surface");
//    fr_Value val;
//    val.i = (fr_Int)r;
//    fr_setInstanceField(env, self, f, &val);
//}

fr_Obj vaseWindow_NGraphics_getBitmap(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "bitmap");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.h);
}

void vaseWindow_NGraphics_setBitmap(fr_Env env, fr_Obj self, fr_Obj r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "bitmap");
    fr_Value val;
    val.h = r;
    fr_setInstanceField(env, self, f, &val);
}

void vaseWindow_NGraphics_init(fr_Env env, fr_Obj self) {
    vaseWindow_NGraphics_setColor(env, self, 255, 0, 0, 0);
}

void vaseWindow_NGraphics_setColor(fr_Env env, fr_Obj self, fr_Int a, fr_Int r, fr_Int g, fr_Int b) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextSetRGBFillColor(vg, r/255.0, g/255.0, b/255.0, a/255.0);
    CGContextSetRGBStrokeColor(vg, r/255.0, g/255.0, b/255.0, a/255.0);
}

void vaseWindow_NGraphics_setPattern(fr_Env env, fr_Obj self, fr_Obj pattern) {
    //TODO
    return;
}
void vaseWindow_NGraphics_setGradient(fr_Env env, fr_Obj self, fr_Obj gradient) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    return;
}
void vaseWindow_NGraphics_setPen(fr_Env env, fr_Obj self, fr_Int width, fr_Int cap, fr_Int join, fr_Obj dash) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);

    
    return;
}
void vaseWindow_NGraphics_setFont(fr_Env env, fr_Obj self, fr_Obj font, fr_Int id, fr_Obj name, fr_Int size, fr_Int blur) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGFontRef cgfont = (CGFontRef)id;
    CGContextSetFont(vg, cgfont);
    CGContextSetFontSize(vg, size);
    return;
}
void vaseWindow_NGraphics_setAntialias(fr_Env env, fr_Obj self, fr_Bool antialias) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextSetShouldAntialias(vg, antialias);
    return;
}
void vaseWindow_NGraphics_setAlpha(fr_Env env, fr_Obj self, fr_Int alpha) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextSetAlpha(vg, alpha / 255.0);
    return;
}
/*
* srcAtop, 0
  srcIn, 1
  srcOut, 2
  srcOver, 3
  dstAtop, 4
  dstIn, 5
  dstOut, 6
  dstOver, 7
  lighter, 8
  copy, 9
  xor, 10
  clear, 11
*/
void vaseWindow_NGraphics_setComposite(fr_Env env, fr_Obj self, fr_Int composite) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGBlendMode op = 0;
    switch (composite)
    {
    case 0://         srcAtop, 0
        op = kCGBlendModeSourceAtop;
        break;
    case 1://         srcIn, 1
        op = kCGBlendModeSourceIn;
        break;
    case 2://         srcOut, 2
        op = kCGBlendModeSourceOut;
        break;
    case 3://         srcOver, 3
        op = kCGBlendModeNormal;
        break;
    case 4://         dstAtop, 4
        op = kCGBlendModeDestinationAtop;
        break;
    case 5://         dstIn, 5
        op = kCGBlendModeDestinationIn;
        break;
    case 6://         dstOut, 6
        op = kCGBlendModeDestinationOut;
        break;
    case 7://         dstOver, 7
        op = kCGBlendModeDestinationOver;
        break;
    case 8://         lighter, 8
        op = kCGBlendModeLighten;
        break;
    case 9://         copy, 9
        op = kCGBlendModeCopy;
        break;
    case 10://         xor, 10
        op = kCGBlendModeXOR;
        break;
    case 11://         clear, 11
        op = kCGBlendModeClear;
        break;
    default:
        break;
    }
    CGContextSetBlendMode(vg, op);
    return;
}

fr_Obj vaseWindow_NGraphics_drawLine(fr_Env env, fr_Obj self, fr_Int x1, fr_Int y1, fr_Int x2, fr_Int y2) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    CGContextMoveToPoint(vg, x1 + 0.5, y1 + 0.5);
    CGContextAddLineToPoint(vg, x2 + 0.5, y2 + 0.5);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawPolyline(fr_Env env, fr_Obj self, fr_Obj ps) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
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
        if (i == 0) CGContextMoveToPoint(vg, x, y);
        else CGContextAddLineToPoint(vg, x, y);
    }
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawPolygon(fr_Env env, fr_Obj self, fr_Obj ps) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
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
        if (i == 0) CGContextMoveToPoint(vg, x, y);
        else CGContextAddLineToPoint(vg, x, y);
    }
    CGContextClosePath(vg);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillPolygon(fr_Env env, fr_Obj self, fr_Obj ps) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
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
        if (i == 0) CGContextMoveToPoint(vg, x, y);
        else CGContextAddLineToPoint(vg, x, y);
    }
    CGContextClosePath(vg);
    CGContextFillPath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextStrokeRect(vg, rect);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextFillRect(vg, rect);
    return self;
}
fr_Obj vaseWindow_NGraphics_clearRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextClearRect(vg, rect);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    fr_Int r = x + w;
    fr_Int b = y + h;
    fr_Int radius = wArc;
    CGContextBeginPath(vg);
    CGContextMoveToPoint(vg, x, y + radius);
    CGContextAddLineToPoint(vg, x, b - radius);
    CGContextAddArcToPoint(vg, x, b, x + radius, b, radius);
    CGContextAddLineToPoint(vg, r - radius, b);
    CGContextAddArcToPoint(vg, r, b, r, b - radius, radius);
    CGContextAddLineToPoint(vg, r, y + radius);
    CGContextAddArcToPoint(vg, r, y, r - radius, y, radius);
    CGContextAddLineToPoint(vg, x + radius, y);
    CGContextAddArcToPoint(vg, x, y, x, y + radius, radius);
    
    CGContextClosePath(vg);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    fr_Int r = x + w;
    fr_Int b = y + h;
    fr_Int radius = wArc;
    CGContextBeginPath(vg);
    CGContextMoveToPoint(vg, x, y + radius);
    CGContextAddLineToPoint(vg, x, b - radius);
    CGContextAddArcToPoint(vg, x, b, x + radius, b, radius);
    CGContextAddLineToPoint(vg, r - radius, b);
    CGContextAddArcToPoint(vg, r, b, r, b - radius, radius);
    CGContextAddLineToPoint(vg, r, y + radius);
    CGContextAddArcToPoint(vg, r, y, r - radius, y, radius);
    CGContextAddLineToPoint(vg, x + radius, y);
    CGContextAddArcToPoint(vg, x, y, x, y + radius, radius);
    
    CGContextClosePath(vg);
    CGContextFillPath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextStrokeEllipseInRect(vg, rect);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillOval(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextFillEllipseInRect(vg, rect);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    double cx = x + (w / 2.0);
    double cy = y + (h / 2.0);
    double rad = MIN(w / 2.0, h / 2.0);
    double sa = PI / 180 * startAngle;
    double ea = PI / 180 * (startAngle + arcAngle);

    CGContextAddArc(vg, cx, cy, rad, -sa, -ea, 0);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillArc(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int startAngle, fr_Int arcAngle) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    
    double cx = x + (w / 2.0);
    double cy = y + (h / 2.0);
    double radius = MIN(w / 2.0, h / 2.0);

    double startRads = PI / 180.0 * startAngle;
    double x1 = cx + (cos(-startRads) * radius);
    double y1 = cy + (sin(-startRads) * radius);

    double endRads = PI / 180.0 * (startAngle + arcAngle);
    double x2 = cx + (cos(-endRads) * radius);
    double y2 = cy + (sin(-endRads) * radius);

    CGContextMoveToPoint(vg, cx, cy);
    CGContextAddLineToPoint(vg, x1, y1);
    CGContextAddArcToPoint(vg, cx, cy, x+w, y+h, radius);
    CGContextAddLineToPoint(vg, x2, y2);
    CGContextClosePath(vg);
    CGContextFillPath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_drawText(fr_Env env, fr_Obj self, fr_Obj s, fr_Int x, fr_Int y) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    const char* str = fr_getStrUtf8(env, s);
    NSString *nsstr = [NSString stringWithUTF8String: str];
    
    fr_Obj font = fr_getFieldS(env, self, "font").h;
    fr_Int size = fr_getFieldS(env, font, "size").i / 2;
    fr_Obj color = fr_getFieldS(env, self, "brush").h;
    fr_Int icolor = 0xff000000;
    if (fr_isInstanceOf(env, color, fr_findType(env, "vaseGraphics", "Color"))) {
        icolor = fr_getFieldS(env, color, "argb").i;
    }
    int a = (icolor >> 24 ) & 0xff;
    int r = (icolor >> 16 ) & 0xff;
    int g = (icolor >> 8 ) & 0xff;
    int b = (icolor >> 0 ) & 0xff;
    
    UIFont *uifont = [UIFont systemFontOfSize:size];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:uifont, NSFontAttributeName,
                           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f], NSForegroundColorAttributeName, nil, nil];
    //NSDictionary *attrs = [[NSDictionary alloc] init];
    int offset = uifont.ascender + uifont.leading;
    [nsstr drawAtPoint:CGPointMake(x,y-offset) withAttributes:attrs];
    //CGContextShowTextAtPoint(vg, x, y, str, strlen(str));
    return self;
}

void vaseWindow_NGraphics_doDrawImage(fr_Env env, fr_Obj self, fr_Obj image, fr_Int srcX, fr_Int srcY, fr_Int srcW, fr_Int srcH, fr_Int dstX, fr_Int dstY, fr_Int dstW, fr_Int dstH) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    fr_Int handle = vaseWindow_NImage_getHandle(env, image);
    if (handle == 0) return;
    CGImageRef img = (CGImageRef)handle;
        
    CGContextSaveGState(vg);
    CGRect iRect = CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img));
    CGRect sRect = CGRectMake(srcX, srcY, srcW, srcH);
    CGRect dRect = CGRectMake(dstX, dstY, dstW, dstH);
    
    float scaleX = (float)dstW / srcW;
    float scaleY = (float)dstH / srcH;
    CGContextTranslateCTM(vg, dstX - (srcX * scaleX), dstY - (srcY * scaleY));
    //nvgTranslate(vg, 50, 50);
    CGContextScaleCTM(vg, scaleX, scaleY);

    CGContextTranslateCTM(vg, 0, srcH);
    CGContextScaleCTM(vg, 1.0, -1.0);

    CGContextClipToRect(vg, sRect);

    CGContextDrawImage(vg, iRect, img);

    CGContextRestoreGState(vg);
    
    //CGRect dRect = CGRectMake(dstX, dstY, dstW, dstH);
    //CGContextDrawImage(vg, dRect, (CGImageRef)handle);
}

void vaseWindow_NGraphics_doClip(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGRect rect = CGRectMake(x, y, w, h);
    CGContextClipToRect(vg, rect);
}
void vaseWindow_NGraphics_pushNative(fr_Env env, fr_Obj self) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextSaveGState(vg);
}
void vaseWindow_NGraphics_popNative(fr_Env env, fr_Obj self) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextRestoreGState(vg);
}
void vaseWindow_NGraphics_dispose(fr_Env env, fr_Obj self) {
    fr_Obj surface = vaseWindow_NGraphics_getBitmap(env, self);
    if (surface) {
        vaseWindow_NImage_endGraphics(env, surface);
        vaseWindow_NGraphics_setContext(env, self, 0);
    }
    return;
}
fr_Obj vaseWindow_NGraphics_drawPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
fr_Obj vaseWindow_NGraphics_fillPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
void vaseWindow_NGraphics_doTransform(fr_Env env, fr_Obj self, fr_Float a, fr_Float b, fr_Float c, fr_Float d, fr_Float e, fr_Float f) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextConcatCTM(vg, CGAffineTransformMake(a, b, c, d, e, f));
}
fr_Obj vaseWindow_NGraphics_clipPath(fr_Env env, fr_Obj self, fr_Obj path) {
    return 0;
}
fr_Obj vaseWindow_NGraphics_setShadow(fr_Env env, fr_Obj self, fr_Obj shadow) {
    return 0;
}
