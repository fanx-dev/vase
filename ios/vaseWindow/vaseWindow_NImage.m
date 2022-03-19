#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

void vaseWindow_NGraphics_setBitmap(fr_Env env, fr_Obj self, fr_Obj r);


fr_Int vaseWindow_NImage_getHandle(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.i);
}

void vaseWindow_NImage_setHandle(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

fr_Int vaseWindow_NImage_getData(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "data");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.i);
}

void vaseWindow_NImage_setData(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "data");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

CGContextRef vaseWindow_NImage_makeCGBitmap(int w, int h) {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
 
    bitmapBytesPerRow   = (w * 4);// 1
    bitmapByteCount     = (bitmapBytesPerRow * h);
 
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    bitmapData = calloc( bitmapByteCount, sizeof(uint8_t) );
    context = CGBitmapContextCreate (bitmapData,// 4
                                    w,
                                    h,
                                    8,      // bits per component
                                    bitmapBytesPerRow,
                                    colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    return context;
}

void vaseWindow_NImage_getSize(fr_Env env, fr_Obj self, int* w, int* h) {
    static fr_Field fw = NULL;
    static fr_Field fh = NULL;
    if (fw == NULL) {
        fr_Type type = fr_getObjType(env, self);
        fw = fr_findField(env, type, "width");
        fh = fr_findField(env, type, "height");
    }
    fr_Value value;
    fr_getInstanceField(env, self, fw, &value);
    *w = value.i;

    fr_getInstanceField(env, self, fh, &value);
    *h = value.i;
}

CGContextRef getContext(fr_Env env, fr_Obj self) {
    CGContextRef bitmapCtx = (CGContextRef)vaseWindow_NImage_getData(env, self);
    if (bitmapCtx == NULL) {
        int w, h;
        vaseWindow_NImage_getSize(env, self, &w, &h);
        bitmapCtx = vaseWindow_NImage_makeCGBitmap(w, h);
        vaseWindow_NImage_setData(env, self, (fr_Int)bitmapCtx);
        
        CGImageRef image = (CGImageRef)vaseWindow_NImage_getHandle(env, self);
        if (image != NULL) {
            CGContextDrawImage(bitmapCtx, CGRectMake(0, 0, w, h), image);
        }
    }
    return bitmapCtx;
}


void vaseWindow_NImage_save(fr_Env env, fr_Obj self, fr_Obj out, fr_Obj format) {
    CGImageRef image = (CGImageRef)vaseWindow_NImage_getHandle(env, self);
    
    CFMutableDataRef cfdata = CFDataCreateMutable(NULL, 0);
    
    CFStringRef cfFormat = kUTTypePNG;
    if (strcmp(fr_getStrUtf8(env, format), "jpg") == 0 || strcmp(fr_getStrUtf8(env, format), "jpeg") == 0) {
        cfFormat = kUTTypeJPEG;
    }
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(cfdata, cfFormat, 1, NULL);
    CGImageDestinationAddImage(destination, image, NULL);
    CGImageDestinationFinalize(destination);
    
    int len = (int)CFDataGetLength(cfdata);
    const unsigned char* png = CFDataGetBytePtr(cfdata);

//	int w, h;
//	vaseWindow_NImage_getSize(env, self, &w, &h);
//
//	int len;
//	int stride_bytes = w * 4;
//	unsigned char* png = stbi_write_png_to_mem((unsigned char*)dataptr, stride_bytes, w, h, 4, &len);

	fr_Obj bufdata = fr_arrayNew(env, fr_findType(env, "sys", "Int"), 1, len);
	memcpy(fr_arrayData(env, bufdata), png, len);
	
    CFRelease(cfdata);

	fr_callOnObj(env, out, "writeBytes", 1, bufdata);
}

fr_Int vaseWindow_NImage_getFlags(fr_Env env, fr_Obj self) {
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "flags");
	fr_Value val;
	fr_getInstanceField(env, self, f, &val);
	return (val.i);
}

void vaseWindow_NImage_setFlags(fr_Env env, fr_Obj self, fr_Int r) {
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "flags");
	fr_Value val;
	val.i = (fr_Int)r;
	fr_setInstanceField(env, self, f, &val);
}

fr_Int vaseWindow_NImage_getPixel(fr_Env env, fr_Obj self, fr_Int x, fr_Int y) {
    CGContextRef bitmapCtx = getContext(env, self);
    char *data = (char*)CGBitmapContextGetData(bitmapCtx);
	int w, h;
	vaseWindow_NImage_getSize(env, self, &w, &h);

	int pos = (w * y + x) * 4;
	int r = data[pos] & (0xff);
	int g = data[pos + 1] & (0xff);
	int b = data[pos + 2] & (0xff);
	int a = data[pos + 3] & (0xff);
	return (a << 24) | (r << 16) | (g << 8) | b;
}

void vaseWindow_NImage_setPixel(fr_Env env, fr_Obj self, fr_Int x, fr_Int y, fr_Int p) {
    CGContextRef bitmapCtx = getContext(env, self);
    char *data = (char*)CGBitmapContextGetData(bitmapCtx);
	int w, h;
	vaseWindow_NImage_getSize(env, self, &w, &h);

	int pos  = (w * y + x) * 4;
	int a = (p & 0xff000000) >> (24);
	int r = (p & 0x00ff0000) >> (16);
	int g = (p & 0x0000ff00) >> (8);
	int b = (p & 0x000000ff);

	data[pos] = r;
	data[pos + 1] = g;
	data[pos + 2] = b;
	data[pos + 3] = a;
    
    vaseWindow_NImage_setFlags(env, self, 1);
}

void vaseWindow_NImage_flush(fr_Env env, fr_Obj self) {
    fr_Int flag = vaseWindow_NImage_getFlags(env, self);
    if (flag == 1) {
        CGImageRef image = (CGImageRef)vaseWindow_NImage_getHandle(env, self);
        if (image != NULL) {
            CGImageRelease(image);
            vaseWindow_NImage_setHandle(env, self, (fr_Int)0);
        }
        
        CGContextRef bitmapCtx = (CGContextRef)vaseWindow_NImage_getData(env, self);
        if (bitmapCtx != NULL) {
            image = CGBitmapContextCreateImage (bitmapCtx);
            vaseWindow_NImage_setHandle(env, self, (fr_Int)image);
        }
        vaseWindow_NImage_setFlags(env, self, 0);
    }
}

void vaseWindow_NImage_dispose(fr_Env env, fr_Obj self) {
    CGContextRef bitmapCtx = (CGContextRef)vaseWindow_NImage_getData(env, self);
	if (bitmapCtx != NULL) {
        char *bitmapData = (char*)CGBitmapContextGetData(bitmapCtx); // 7
        CGContextRelease (bitmapCtx);// 8
        if (bitmapData) free(bitmapData); // 9
        vaseWindow_NImage_setHandle(env, self, (fr_Int)0);
	}
	
    CGImageRef image = (CGImageRef)vaseWindow_NImage_getHandle(env, self);
    if (image != NULL) {
        CGImageRelease(image);
        vaseWindow_NImage_setHandle(env, self, 0);
    }
	return;
}

void vaseWindow_NImage_endGraphics(fr_Env env, fr_Obj self) {
    CGContextRef bitmapCtx = (CGContextRef)vaseWindow_NImage_getData(env, self);
    
    if (bitmapCtx != NULL) {
        CGImageRef image = CGBitmapContextCreateImage (bitmapCtx);
        vaseWindow_NImage_setHandle(env, self, (fr_Int)image);
    }
}

fr_Obj vaseWindow_NImage_createGraphics(fr_Env env, fr_Obj self) {
    CGContextRef bitmapCtx = getContext(env, self);
	fr_Obj graphics = fr_newObjS(env, "vaseWindow", "NGraphics", "make", 1, bitmapCtx);
	vaseWindow_NGraphics_setBitmap(env, graphics, self);
	return graphics;
}

void vaseWindow_NImage_finalize(fr_Env env, fr_Obj self) {
    vaseWindow_NImage_dispose(env, self);
}
