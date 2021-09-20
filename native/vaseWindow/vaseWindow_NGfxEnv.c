#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#include "nanovg.h"
#include "stb_image.h"

#include <stdlib.h>
#include <memory.h>

extern NVGcontext* g_nanovg;

void vaseWindow_NGfxEnv_initFont(fr_Env env, fr_Obj self, fr_Obj font) {
    fr_Obj name = fr_getFieldS(env, font, "name").h;
    const char* fname = fr_getStrUtf8(env, name);
    int fid = nvgFindFont(g_nanovg, fname);

    if (fid == -1) fid = nvgFindFont(g_nanovg, "sans");

    fr_Value value;
    value.i = fid;
    fr_setFieldS(env, font, "handle", value);
    return;
}

struct InputStreamCtx {
    fr_Obj in;
    fr_Env env;
    bool isEof;
};

static int read(void* user, char* data, int size) {
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
    int components = 4;
    int size = w * h * components;
    char* data = (char*)calloc(1, size);

    fr_Obj bitmap = fr_newObjS(env, "vaseWindow", "NImage", "makeData", 3, (fr_Int)data, (fr_Int)w, (fr_Int)h);
    return bitmap;
}

fr_Obj vaseWindow_NGfxEnv_fromStream(fr_Env env, fr_Obj self, fr_Obj in) {

    stbi_io_callbacks callbacks;
    struct InputStreamCtx ctx;
    callbacks.read = read;
    callbacks.skip = skip;
    callbacks.eof = eof;
    ctx.env = env;
    ctx.in = in;
    ctx.isEof = false;

    int width, height, components;
    stbi_uc* data = stbi_load_from_callbacks(&callbacks, &ctx, &width, &height, &components, STBI_rgb_alpha);
    if (!data)
    {
        fr_throwNew(env, "sys", "IOErr", "unsupported");
        return;
    }

    //int size = width * height * components;

    fr_Obj bitmap = fr_newObjS(env, "vaseWindow", "NImage", "makeData", 3, (fr_Int)data, (fr_Int)width, (fr_Int)height);
    return bitmap;
}
fr_Bool vaseWindow_NGfxEnv_contains(fr_Env env, fr_Obj self, fr_Obj path, fr_Float x, fr_Float y) {
    return 0;
}
void vaseWindow_NGfxEnv_finalize(fr_Env env, fr_Obj self) {
    return 0;
}