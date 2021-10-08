#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


//#define STB_IMAGE_IMPLEMENTATION
//#include "stb_image.h"

#include <stdlib.h>
#include <memory.h>

void vaseWindow_NFont_setHandle(fr_Env env, fr_Obj self, fr_Int r);
void vaseWindow_NImage_setHandle(fr_Env env, fr_Obj self, fr_Int r);
CGContextRef vaseWindow_NImage_makeCGBitmap(int w, int h);
void vaseWindow_NGraphics_applyPath(fr_Env env, CGContextRef vg, fr_Obj path);

void vaseWindow_NGfxEnv_initFont(fr_Env env, fr_Obj self, fr_Obj font) {
    fr_Obj name = fr_getFieldS(env, font, "name").h;
    const char* fname = fr_getStrUtf8(env, name);

    CFStringRef fontName = CFStringCreateWithCString(NULL, fname, CFStringGetSystemEncoding());
    CGFontRef aFont = CGFontCreateWithFontName(fontName);
    CFRelease(fontName);

    vaseWindow_NFont_setHandle(env, font, (fr_Int)aFont);
    return;
}

struct InputStreamCtx {
    fr_Obj in;
    fr_Env env;
    bool isEof;
};

static int data_read(void* user, char* data, int size) {
    struct InputStreamCtx* ctx = (struct InputStreamCtx*)user;
    fr_Method method = fr_findMethodN(ctx->env, fr_getObjType(ctx->env, ctx->in), "readBytes", 1);

    fr_Obj dataArray = fr_arrayNew(ctx->env, fr_findType(ctx->env, "sys", "Int"), 1, size);

    int readSize = fr_callMethod(ctx->env, method, 2, ctx->in, dataArray).i;

    if (readSize > 0) {
        char* rawdata = fr_arrayData(ctx->env, dataArray);
        memcpy(data, rawdata, readSize);
    }

    if (readSize != size) {
        ctx->isEof = true;
    }

    return readSize;
}

static void skip(void* user, int n) {
    struct InputStreamCtx* ctx = (struct InputStreamCtx*)user;
    fr_Method method = fr_findMethod(ctx->env, fr_getObjType(ctx->env, ctx->in), "skip");
    fr_callMethod(ctx->env, method, 2, ctx->in, (fr_Int)n);
}
static int eof(void* user) {
    struct InputStreamCtx* ctx = (struct InputStreamCtx*)user;
    return ctx->isEof;
}

fr_Obj vaseWindow_NGfxEnv_allocImage(fr_Env env, fr_Obj self, fr_Int w, fr_Int h) {
    CGContextRef bitmapCtx = vaseWindow_NImage_makeCGBitmap((int)w, (int)h);

    fr_Obj bitmap = fr_newObjS(env, "vaseWindow", "NImage", "makeData", 3, (fr_Int)bitmapCtx, (fr_Int)w, (fr_Int)h);
    return bitmap;
}

CGImageRef makeCGImage(uint8_t *data, int w, int h) {
    int componentsPerPixel = 4;
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    
    size_t bufferLength = w * h * componentsPerPixel;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, bufferLength, NULL);
    size_t bytesPerRow = componentsPerPixel * w;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;

    CGImageRef iref = CGImageCreate(w,
                                  h,
                                  bitsPerComponent,
                                  bitsPerPixel,
                                  bytesPerRow,
                                  CGColorSpaceCreateDeviceRGB(),
                                  kCGBitmapByteOrder32Little | kCGImageAlphaFirst,
                                  provider,
                                  NULL,
                                  true,
                                  renderingIntent);
    CGDataProviderRelease(provider);
//    UIImage * img = [UIImage imageNamed:@"image.png"];
//    CGImageRef temImg = img.CGImage;
    
    return iref;
}

fr_Obj vaseWindow_NGfxEnv_fromStream(fr_Env env, fr_Obj self, fr_Obj in) {
    
//    stbi_io_callbacks callbacks;
//    struct InputStreamCtx ctx;
//    callbacks.read = data_read;
//    callbacks.skip = skip;
//    callbacks.eof = eof;
//    ctx.env = env;
//    ctx.in = in;
//    ctx.isEof = false;
//
//    int width, height, components;
//    stbi_uc* data = stbi_load_from_callbacks(&callbacks, &ctx, &width, &height, &components, STBI_rgb_alpha);
//    if (!data)
//    {
//        fr_throwNew(env, "sys", "IOErr", "unsupported");
//        return NULL;
//    }
//
//    //int size = width * height * components;
//    CGImageRef image = makeCGImage(data, width, height);
    
    fr_Obj buf = fr_callOnObj(env, in, "readAllBuf", 0).h;
    fr_Obj data = fr_callOnObj(env, buf, "unsafeArray", 0).h;
    char* buffer = (char*)fr_arrayData(env, data);
    int len = fr_callOnObj(env, buf, "size", 0).i;
    
    NSData *nsdata = [NSData dataWithBytes:buffer length:len];
    UIImage *uiImage = [UIImage imageWithData:nsdata];
    CGImageRef image = uiImage.CGImage;
    CGImageRetain(image);
    int width = uiImage.size.width;
    int height = uiImage.size.height;
    
    fr_Obj bitmap = fr_newObjS(env, "vaseWindow", "NImage", "makeData", 3, (fr_Int)NULL, (fr_Int)width, (fr_Int)height);
    vaseWindow_NImage_setHandle(env, bitmap, (fr_Int)image);
    return bitmap;
}
fr_Bool vaseWindow_NGfxEnv_contains(fr_Env env, fr_Obj self, fr_Obj path, fr_Float x, fr_Float y) {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    vaseWindow_NGraphics_applyPath(env, ctx, path);
    bool res = CGContextPathContainsPoint(ctx, CGPointMake(x, y), kCGPathFill);
    CGContextBeginPath(ctx);
    return res;
}
void vaseWindow_NGfxEnv_finalize(fr_Env env, fr_Obj self) {
    return;
}
