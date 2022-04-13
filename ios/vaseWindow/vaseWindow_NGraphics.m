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
void vaseWindow_NImage_getSize(fr_Env env, fr_Obj self, int* w, int* h);
void vaseWindow_NImage_flush(fr_Env env, fr_Obj self);
UIFont *vaseWindow_NFont_font(fr_Env env, fr_Obj self);

void decodeColor(fr_Int icolor, float color[4]) {
    int a = (icolor >> 24 ) & 0xff;
    int r = (icolor >> 16 ) & 0xff;
    int g = (icolor >> 8 ) & 0xff;
    int b = (icolor >> 0 ) & 0xff;
    
    color[0] = a / 255.0;
    color[1] = r / 255.0;
    color[2] = g / 255.0;
    color[3] = b / 255.0;
}

fr_Obj curBrush(fr_Env env, fr_Obj self) {
    static fr_Field field;
    if (!field) {
        field = fr_findField(env, fr_getObjType(env, self), "brush");
    }
    fr_Value value;
    fr_getInstanceField(env, self, field, &value);
    return value.h;
}

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
    //CGPatternRef cgpattern = pattern
    return;
}
void vaseWindow_NGraphics_setGradient(fr_Env env, fr_Obj self, fr_Obj gradient) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    return;
}
void vaseWindow_NGraphics_setPen(fr_Env env, fr_Obj self, fr_Int width, fr_Int cap, fr_Int join, fr_Obj dash) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextSetLineWidth(vg, width);
    
    CGLineJoin cgjoin = kCGLineJoinMiter;
    switch (join) {
        case 0:
            cgjoin = kCGLineJoinMiter;
            break;
        case 1:
            cgjoin = kCGLineJoinBevel;
            break;
        case 3:
            cgjoin = kCGLineJoinRound;
            break;
    }
    CGContextSetLineJoin(vg, cgjoin);
    
    CGLineCap cgcap = kCGLineCapSquare;
    switch (cap) {
        case 0:
            cgcap = kCGLineCapSquare;
            break;
        case 1:
            cgcap = kCGLineCapButt;
            break;
        case 2:
            cgcap = kCGLineCapRound;
            break;
    }
    CGContextSetLineCap(vg, cgcap);
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
        x = fr_callMethod(env, getXM, 2, ps, (fr_Int)i).i;
        y = fr_callMethod(env, getYM, 2, ps, (fr_Int)i).i;
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
        x = fr_callMethod(env, getXM, 2, ps, (fr_Int)i).i;
        y = fr_callMethod(env, getYM, 2, ps, (fr_Int)i).i;
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
        x = fr_callMethod(env, getXM, 2, ps, (fr_Int)i).i;
        y = fr_callMethod(env, getYM, 2, ps, (fr_Int)i).i;
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
    
    fr_Obj brush = curBrush(env, self);
    static fr_Type gradientType;
    if (!gradientType) gradientType = fr_findType(env, "vaseGraphics", "Gradient");
    if (fr_isInstanceOf(env, brush, gradientType)) {
        fr_Int mode = fr_callOnObj(env, fr_getFieldS(env, brush, "mode").h, "ordinal", 0).i;
        if (mode == 0) {
            CGContextSaveGState(vg);
            CGRect rect = CGRectMake(x, y, w, h);
            CGContextClipToRect(vg, rect);
            int x1 = (int)fr_getFieldS(env, brush, "x1").i;
            int y1 = (int)fr_getFieldS(env, brush, "y1").i;
            int x2 = (int)fr_getFieldS(env, brush, "x2").i;
            int y2 = (int)fr_getFieldS(env, brush, "y2").i;
            fr_Obj stops = fr_getFieldS(env, brush, "stops").h;
            fr_Obj stop1 = fr_callOnObj(env, stops, "get", 1, (fr_Int)0).h;
            fr_Obj stop2 = fr_callOnObj(env, stops, "get", 1, (fr_Int)-1).h;
            fr_Int icolor1 = fr_getFieldS(env, fr_getFieldS(env, stop1, "color").h, "argb").i;
            fr_Int icolor2 = fr_getFieldS(env, fr_getFieldS(env, stop2, "color").h, "argb").i;
            
            
            float color1[4];
            float color2[4];
            decodeColor(icolor1, color1);
            decodeColor(icolor2, color2);
            
            CGGradientRef myGradient;
            CGColorSpaceRef myColorspace;
            size_t num_locations = 2;
            CGFloat locations[2] = { 0.0, 1.0 };
            CGFloat components[8] = { color1[1], color1[2], color1[3], color1[0],  // Start color
                                      color2[1], color2[2], color2[3], color2[0] }; // End color
             
            myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
            myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                      locations, num_locations);
            
            
            CGPoint myStartPoint, myEndPoint;
            myStartPoint.x = x1;
            myStartPoint.y = y1;
            myEndPoint.x = x2;
            myEndPoint.y = y2;
            CGContextDrawLinearGradient (vg, myGradient, myStartPoint, myEndPoint, 0);
            
            CGColorSpaceRelease(myColorspace);
            CGGradientRelease(myGradient);
            
            CGContextRestoreGState(vg);
            return self;
        }
    }
    
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

void pathRoundRect(CGContextRef vg, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    if (wArc > w/2) wArc = w/2;
    if (hArc > h/2) hArc = h/2;
    
    CGContextBeginPath(vg);
    
    CGContextMoveToPoint(vg, x + wArc, y);
    CGContextAddLineToPoint(vg, x + w - wArc, y);

    //right top
    //this.cx.arc(x+w-wArc, y+hArc, wArc, -90*(Math.PI / 180), true);
    CGContextAddArcToPoint(vg, x + w, y, x + w, y + hArc, wArc);
    CGContextAddLineToPoint(vg, x + w, y + h - hArc);

    //right bottom
    //this.cx.arc(x+w-wArc, y+h-hArc, wArc, 0, 90*(Math.PI / 180), true);
    CGContextAddArcToPoint(vg, x + w, y + h , x + w - wArc, y + h, wArc);
    CGContextAddLineToPoint(vg, x + wArc, y + h);
    
    //left bottom
    //this.cx.arc(x+wArc, y+h-hArc, wArc, 90*(Math.PI / 180), 90*(Math.PI / 180), true)
    CGContextAddArcToPoint(vg, x, y + h , x, y + h - hArc, wArc);
    CGContextAddLineToPoint(vg, x, y + hArc);

    //left top
    //this.cx.arc(x+wArc, y+hArc, wArc, 180*(Math.PI / 180), 90*(Math.PI / 180), true);
    CGContextAddArcToPoint(vg, x, y, x + wArc, y, wArc);
    
    CGContextClosePath(vg);
}
fr_Obj vaseWindow_NGraphics_drawRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    pathRoundRect(vg, x, y, w, h, wArc, hArc);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillRoundRect(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int w, fr_Int h, fr_Int wArc, fr_Int hArc) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    pathRoundRect(vg, x, y, w, h, wArc, hArc);
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
    if (!font) {
        printf("ERROR: font is null\n");
        return self;
    }
    fr_Obj brush = curBrush(env, self);
    static fr_Type colorType;
    if (!colorType) colorType = fr_findType(env, "vaseGraphics", "Color");
    fr_Int icolor = 0xff000000;
    if (fr_isInstanceOf(env, brush, colorType)) {
        icolor = fr_getFieldS(env, brush, "argb").i;
    }
    float color[4];
    decodeColor(icolor, color);
    
    UIFont *uifont = vaseWindow_NFont_font(env, font);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:uifont, NSFontAttributeName,
                           [UIColor colorWithRed:color[1] green:color[2] blue:color[3] alpha:color[0]], NSForegroundColorAttributeName, nil, nil];
    //NSDictionary *attrs = [[NSDictionary alloc] init];
    int offset = uifont.ascender + uifont.leading;
    [nsstr drawAtPoint:CGPointMake(x,y-offset) withAttributes:attrs];
    //CGContextShowTextAtPoint(vg, x, y, str, strlen(str));
    return self;
}

void vaseWindow_NGraphics_doDrawImage(fr_Env env, fr_Obj self, fr_Obj image, fr_Int srcX, fr_Int srcY, fr_Int srcW, fr_Int srcH, fr_Int dstX, fr_Int dstY, fr_Int dstW, fr_Int dstH) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    vaseWindow_NImage_flush(env, image);
    fr_Int handle = vaseWindow_NImage_getHandle(env, image);
    if (handle == 0) return;
    CGImageRef img = (CGImageRef)handle;
    
    CGContextSaveGState(vg);
    CGRect iRect = CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img));
    //CGRect sRect = CGRectMake(srcX, srcY, srcW, srcH);
    CGRect dRect = CGRectMake(dstX, dstY, dstW, dstH);
    
    CGContextClipToRect(vg, dRect);
    
    CGRect nRect;
    double scaleX = (double)dstW / srcW;
    double scaleY = (double)dstH / srcH;
    //nRect.origin.x = (iRect.origin.x - (srcX+srcW/2.0)) * scaleX + (dstX + dstW/2.0);
    //nRect.origin.y = (iRect.origin.y - (srcY+srcH/2.0)) * scaleY + (dstY + dstH/2.0);
    nRect.origin.x = dstX - (srcX * scaleX);
    nRect.origin.y = dstY - (srcY * scaleY);
    nRect.size.width = iRect.size.width * scaleX;
    nRect.size.height = iRect.size.height * scaleY;
    
//    fr_Obj surface = vaseWindow_NGraphics_getBitmap(env, self);
//    if (surface == NULL)
    {
        double y = nRect.origin.y+nRect.size.height/2.0;
        CGContextTranslateCTM(vg, 0, y);
        CGContextScaleCTM(vg, 1.0, -1.0);
        CGContextTranslateCTM(vg, 0, -y);
    }
    
    CGContextDrawImage(vg, nRect, img);

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

void vaseWindow_NGraphics_applyPath(fr_Env env, CGContextRef vg, fr_Obj path) {
    fr_Obj steps = fr_getFieldS(env, path, "steps").h;
    fr_Int size = fr_callOnObj(env, steps, "size", 0).i;
    fr_Method getM = fr_findMethod(env, fr_getObjType(env,steps), "get");
    
    fr_Type PathMoveTo = fr_findType(env, "vaseGraphics", "PathMoveTo");
    fr_Type PathLineTo = fr_findType(env, "vaseGraphics", "PathLineTo");
    fr_Type PathQuadTo = fr_findType(env, "vaseGraphics", "PathQuadTo");
    fr_Type PathCubicTo = fr_findType(env, "vaseGraphics", "PathCubicTo");
    fr_Type PathClose = fr_findType(env, "vaseGraphics", "PathClose");
    fr_Type PathArc = fr_findType(env, "vaseGraphics", "PathArc");
    for (int i=0; i<size; ++i) {
        fr_Obj step = fr_callMethod(env, getM, 2, steps, (fr_Int)i).h;
        if (fr_isInstanceOf(env, step, PathMoveTo)) {
            double x = fr_getFieldS(env, step, "x").f;
            double y = fr_getFieldS(env, step, "y").f;
            CGContextMoveToPoint(vg, x, y);
        }
        else if (fr_isInstanceOf(env, step, PathLineTo)) {
            double x = fr_getFieldS(env, step, "x").f;
            double y = fr_getFieldS(env, step, "y").f;
            CGContextAddLineToPoint(vg, x, y);
        }
        else if (fr_isInstanceOf(env, step, PathQuadTo)) {
            double cx = fr_getFieldS(env, step, "cx").f;
            double cy = fr_getFieldS(env, step, "cy").f;
            double x = fr_getFieldS(env, step, "x").f;
            double y = fr_getFieldS(env, step, "y").f;
            CGContextAddQuadCurveToPoint(vg, cx, cy, x, y);
        }
        else if (fr_isInstanceOf(env, step, PathCubicTo)) {
            double cx1 = fr_getFieldS(env, step, "cx1").f;
            double cy1 = fr_getFieldS(env, step, "cy1").f;
            double cx2 = fr_getFieldS(env, step, "cx2").f;
            double cy2 = fr_getFieldS(env, step, "cy2").f;
            double x = fr_getFieldS(env, step, "x").f;
            double y = fr_getFieldS(env, step, "y").f;
            CGContextAddCurveToPoint(vg, cx1, cy1, cx2, cy2, x, y);
        }
        else if (fr_isInstanceOf(env, step, PathClose)) {
            CGContextClosePath(vg);
        }
        else if (fr_isInstanceOf(env, step, PathArc)) {
            double cx = fr_getFieldS(env, step, "cx").f;
            double cy = fr_getFieldS(env, step, "cy").f;
            double radius = fr_getFieldS(env, step, "radius").f;
            double startAngle = fr_getFieldS(env, step, "startAngle").f;
            double arcAngle = fr_getFieldS(env, step, "arcAngle").f;
            
            double sa = startAngle * (PI / 180.0);
            double ea = (startAngle + arcAngle) * (PI / 180.0);
            CGContextAddArc(vg, cx, cy, radius, sa, ea, 0);
        }
    }
}

fr_Obj vaseWindow_NGraphics_drawPath(fr_Env env, fr_Obj self, fr_Obj path) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    vaseWindow_NGraphics_applyPath(env, vg, path);
    CGContextStrokePath(vg);
    return self;
}
fr_Obj vaseWindow_NGraphics_fillPath(fr_Env env, fr_Obj self, fr_Obj path) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    vaseWindow_NGraphics_applyPath(env, vg, path);
    CGContextFillPath(vg);
    return self;
}
void vaseWindow_NGraphics_doTransform(fr_Env env, fr_Obj self, fr_Float a, fr_Float b, fr_Float c, fr_Float d, fr_Float e, fr_Float f) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextConcatCTM(vg, CGAffineTransformMake(a, b, c, d, e, f));
}
fr_Obj vaseWindow_NGraphics_clipPath(fr_Env env, fr_Obj self, fr_Obj path) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    CGContextBeginPath(vg);
    vaseWindow_NGraphics_applyPath(env, vg, path);
    CGContextClip(vg);
    return self;
}
void vaseWindow_NGraphics_doSetShadow(fr_Env env, fr_Obj self, fr_Bool valide, fr_Int blur, fr_Int offsetX, fr_Int offsetY,
                                        fr_Int a, fr_Int r, fr_Int g, fr_Int b) {
    CGContextRef vg = (CGContextRef)vaseWindow_NGraphics_getContext(env, self);
    if (valide) {
        CGContextSetShadowWithColor(vg, CGSizeMake(offsetX, offsetY), blur, CGColorCreateGenericRGB(r/255.0, g/255.0, b/255.0, a/255.0));
    }
    else {
        CGContextSetShadowWithColor(vg, CGSizeMake(0, 0), 0, NULL);
    }
}
