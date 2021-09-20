#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#include "nanovg.h"
#include "nanovg_gl.h"
#include "nanovg_gl_utils.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

extern NVGcontext* g_nanovg;
void vaseWindow_NGraphics_setBitmap(fr_Env env, fr_Obj self, fr_Obj r);


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
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "data");
	fr_Value val;
	fr_getInstanceField(env, self, f, &val);
	return (char*)(val.i);
}

void vaseWindow_NImage_setData(fr_Env env, fr_Obj self, char * r) {
	static fr_Field f = NULL;
	if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "data");
	fr_Value val;
	val.i = (fr_Int)r;
	fr_setInstanceField(env, self, f, &val);
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

void vaseWindow_NImage_save(fr_Env env, fr_Obj self, fr_Obj out, fr_Obj format) {
	char* dataptr = vaseWindow_NImage_getData(env, self);

	int w, h;
	vaseWindow_NImage_getSize(env, self, &w, &h);
	
	int len;
	int stride_bytes = w * 4;
	unsigned char* png = stbi_write_png_to_mem((unsigned char*)dataptr, stride_bytes, w, h, 4, &len);

	fr_Obj bufdata = fr_arrayNew(env, fr_findType(env, "sys", "Int"), 1, len);
	memcpy(fr_arrayData(env, bufdata), png, len);
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

fr_Int vaseWindow_NImage_getPixel(fr_Env env, fr_Obj self, fr_Int x, fr_Int y) {
	char* data = vaseWindow_NImage_getData(env, self);
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
	char* data = vaseWindow_NImage_getData(env, self);
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
}

void vaseWindow_NImage_dispose(fr_Env env, fr_Obj self) {
	if (vaseWindow_NImage_getFlags(env, self) != 0) {
		NVGLUframebuffer* fb = (NVGLUframebuffer*)vaseWindow_NImage_getHandle(env, self);
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

void vaseWindow_NImage_endGraphics(fr_Env env, fr_Obj self) {
	nvgEndFrame(g_nanovg);

	char* dataptr = vaseWindow_NImage_getData(env, self);
	int w, h;
	vaseWindow_NImage_getSize(env, self, &w, &h);
	glReadPixels(0, 0, w, h, GL_RGBA, GL_UNSIGNED_BYTE, dataptr);
	flipHorizontal(dataptr, w, h, w * 4);

	nvgluBindFramebuffer(NULL);

	nvgBeginFrame(g_nanovg, w, h, 1);
	nvgRestore(g_nanovg);
}

fr_Obj vaseWindow_NImage_createGraphics(fr_Env env, fr_Obj self) {
	if (g_nanovg == NULL) {
		printf("state error\n");
		fr_throwUnsupported(env);
		return NULL;
	}
	nvgSave(g_nanovg);
	nvgEndFrame(g_nanovg);

	NVGLUframebuffer* fb = NULL;
	int w, h;
	vaseWindow_NImage_getSize(env, self, &w, &h);

	if (vaseWindow_NImage_getFlags(env, self) == 0) {
		
		fb = nvgluCreateFramebuffer(g_nanovg, w, h, 0);
		if (fb == NULL) {
			printf("Could not create FBO.\n");
			fr_throwUnsupported(env);
			return NULL;
		}

		if (vaseWindow_NImage_getHandle(env, self)) {
			vaseWindow_NImage_dispose(env, self);
		}
		vaseWindow_NImage_setHandle(env, self, fb);
		vaseWindow_NImage_setFlags(env, self, 1);
	}
	else {
		fb = vaseWindow_NImage_getHandle(env, self);
	}

	nvgluBindFramebuffer(fb);
	glViewport(0, 0, w, h);
	glClearColor(0, 0, 0, 0);
	//glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
	glClear(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
	nvgBeginFrame(g_nanovg, w, h, 1);

	nvgUpdateImage(g_nanovg, fb->image, vaseWindow_NImage_getData(env, self));


	/*nvgBeginPath(g_nanovg);
	nvgCircle(g_nanovg, 10, 10, 10);
	nvgCircle(g_nanovg, 100, 100, 10);
	nvgFillColor(g_nanovg, nvgRGBA(220, 160, 0, 200));
	nvgFill(g_nanovg);*/

	fr_Obj graphics = fr_newObjS(env, "vaseWindow", "NGraphics", "make", 1, g_nanovg);
	vaseWindow_NGraphics_setBitmap(env, graphics, self);
	return graphics;
}

void vaseWindow_NImage_finalize(fr_Env env, fr_Obj self) {
	char* data = vaseWindow_NImage_getData(env, self);
	free(data);
	vaseWindow_NImage_setData(env, self, NULL);
}
