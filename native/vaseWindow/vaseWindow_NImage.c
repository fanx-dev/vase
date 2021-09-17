#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#include "nanovg.h"
#include "nanovg_gl.h"
#define NANOVG_GL_IMPLEMENTATION
#include "nanovg_gl_utils.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

extern NVGcontext* g_nanovg;
void vaseWindow_NGraphics_setSurface(fr_Env env, fr_Obj self, fr_Int r);
void vaseWindow_NGraphics_setNvgContext(fr_Env env, fr_Obj self, NVGcontext* r);


static void flipHorizontal(unsigned char* image, int w, int h, int stride)
{
	int i = 0, j = h - 1, k;
	while (i < j) {
		unsigned char* ri = &image[i * stride];
		unsigned char* rj = &image[j * stride];
		for (k = 0; k < w * 4; k++) {
			unsigned char t = ri[k];
			ri[k] = rj[k];
			rj[k] = t;
		}
		i++;
		j--;
	}
}

char* vaseWindow_NImage_getData(fr_Env env, fr_Obj self) {
	fr_Obj data = fr_getFieldS(env, self, "data").h;
	char* dataptr = fr_arrayData(env, data);
	return dataptr;
}

void vaseWindow_NImage_save(fr_Env env, fr_Obj self, fr_Obj out, fr_Obj format) {
	fr_Obj data = fr_getFieldS(env, self, "data").h;
	char* dataptr = fr_arrayData(env, data);

	int w = fr_getFieldS(env, self, "width").i;
	int h = fr_getFieldS(env, self, "height").i;
	glReadPixels(0, 0, w, h, GL_RGBA, GL_UNSIGNED_BYTE, dataptr);
	flipHorizontal(dataptr, w, h, w * 4);
	
	int len;
	int stride_bytes = w * 4;
	unsigned char* png = stbi_write_png_to_mem((unsigned char*)data, stride_bytes, w, h, 4, &len);

	int size = w * h * 4;
	fr_Obj bufdata = fr_arrayNew(env, fr_findType(env, "sys", "Array"), 1, size);
	memcpy(bufdata, png, size);
	free(png);

	fr_callOnObj(env, out, "writeBytes", 1, bufdata);
}

fr_Int vaseWindow_NImage_getHandle(fr_Env env, fr_Obj self) {
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
	fr_Value val;
	fr_getInstanceField(env, self, f, &val);
	return (val.i);
}

void vaseWindow_NImage_getSize(fr_Env env, fr_Obj self, int *w, int *h) {
	*w = fr_getFieldS(env, self, "width").i;
	*h = fr_getFieldS(env, self, "height").i;
}

void vaseWindow_NImage_setHandle(fr_Env env, fr_Obj self, fr_Int r) {
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
	fr_Value val;
	val.i = (fr_Int)r;
	fr_setInstanceField(env, self, f, &val);
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

void vaseWindow_NImage_dispose(fr_Env env, fr_Obj self) {
	if (vaseWindow_NImage_getFlags(env, self) != 0) {
		NVGLUframebuffer* fb = vaseWindow_NImage_getHandle(env, self);
		nvgluDeleteFramebuffer(fb);
	}
	else {
		int handle = vaseWindow_NImage_getHandle(env, self);
		if (handle != 0) {
			nvgDeleteImage(g_nanovg, handle);
		}
	}
	vaseWindow_NImage_setHandle(env, self, 0);
	return;
}

fr_Obj vaseWindow_NImage_createGraphics(fr_Env env, fr_Obj self) {

    NVGLUframebuffer* fb = NULL;
	int w = fr_getFieldS(env, self, "width").i;
	int h = fr_getFieldS(env, self, "height").i;
	fb = nvgluCreateFramebuffer(g_nanovg, w, h, 0);
	if (fb == NULL) {
		printf("Could not create FBO.\n");
		return -1;
	}

	if (vaseWindow_NImage_getHandle(env, self)) {
		vaseWindow_NImage_dispose(env, self);
	}
	vaseWindow_NImage_setHandle(env, self, fb);
	vaseWindow_NImage_setFlags(env, self, 1);

	nvgluBindFramebuffer(fb);
	glViewport(0, 0, w, h);
	glClearColor(0, 0, 0, 0);
	glClear(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
	nvgBeginFrame(g_nanovg, w, h, 1);


	fr_Obj graphics = fr_newObjS(env, "vaseWindow", "NGraphics", "make", 0);
	vaseWindow_NGraphics_setNvgContext(env, graphics, g_nanovg);
	vaseWindow_NGraphics_setSurface(env, graphics, fb);
	return graphics;
}
