#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include "GL/glew.h"
#define GLFW_INCLUDE_NONE
#include "GLFW/glfw3.h"

#include "nanovg.h"

#define NANOVG_GL3_IMPLEMENTATION
#include "nanovg_gl.h"

#include <stdlib.h>
#include <stdio.h>

struct Window {
    GLFWwindow* window;
    NVGcontext *nanovg;
};

static struct Window* getWindow(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    struct Window* raw = (struct Window*)(val.i);
    return raw;
}

static void setWindow(fr_Env env, fr_Obj self, struct Window* r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

void vaseWindow_NWindow_repaint(fr_Env env, fr_Obj self, fr_Obj dirty) {
    return;
}

static void error_callback(int error, const char* description)
{
    fprintf(stderr, "Error: %s\n", description);
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
        glfwSetWindowShouldClose(window, GLFW_TRUE);
}

void drawFrame(GLFWwindow* window, NVGcontext* vg) {

    double mx, my, t, dt;
    int winWidth, winHeight;
    int fbWidth, fbHeight;
    float pxRatio;
    float gpuTimes[3];
    int i, n;

    glfwGetCursorPos(window, &mx, &my);
    glfwGetWindowSize(window, &winWidth, &winHeight);
    glfwGetFramebufferSize(window, &fbWidth, &fbHeight);
    // Calculate pixel ration for hi-dpi devices.
    pxRatio = (float)fbWidth / (float)winWidth;

    // Update and render
    glViewport(0, 0, fbWidth, fbHeight);

    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);

    nvgBeginFrame(vg, winWidth, winHeight, pxRatio);

    nvgBeginPath(vg);
    nvgRect(vg, 100, 100, 150, 30);
    nvgFillColor(vg, nvgRGBA(255, 192, 0, 255));
    nvgFill(vg);


    nvgFontSize(vg, 35.0f);
    nvgFontFace(vg, "sans");
    nvgFillColor(vg, nvgRGBA(0, 0, 0, 160));

    nvgTextAlign(vg, NVG_ALIGN_LEFT | NVG_ALIGN_MIDDLE);
    nvgText(vg, 108, 200, "北京", NULL);

    nvgEndFrame(vg);
}

void vaseWindow_NWindow_show(fr_Env env, fr_Obj self, fr_Obj size) {
    struct Window* handle = malloc(sizeof(struct Window));
    GLFWwindow* window;
    //GLuint vertex_buffer, vertex_shader, fragment_shader, program;
    //GLint mvp_location, vpos_location, vcol_location;

    glfwSetErrorCallback(error_callback);

    if (!glfwInit())
        exit(EXIT_FAILURE);

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);

    window = glfwCreateWindow(600, 600, "Simple example", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }

    glfwSetKeyCallback(window, key_callback);

    glfwMakeContextCurrent(window);
    glewInit();
    glfwSwapInterval(1);

    handle->window = window;
    handle->nanovg = nvgCreateGL3(NVG_ANTIALIAS | NVG_STENCIL_STROKES | NVG_DEBUG);
    setWindow(env, self, handle);
#if _WIN64
    int font = nvgCreateFont(handle->nanovg, "sans", "C:\\Windows\\Fonts\\msyh.ttc");
    assert(font != -1);
#endif

    while (!glfwWindowShouldClose(window))
    {
        float ratio;
        int width, height;
        //mat4x4 m, p, mvp;

        glfwGetFramebufferSize(window, &width, &height);
        ratio = width / (float)height;

        drawFrame(window, handle->nanovg);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    nvgDeleteGL3(handle->nanovg);
    handle->nanovg = NULL;
    setWindow(env, self, NULL);
    free(handle);

    glfwDestroyWindow(window);

    glfwTerminate();
    exit(EXIT_SUCCESS);
}
fr_Int vaseWindow_NWindow_x(fr_Env env, fr_Obj self) {
    return 0;
}
fr_Int vaseWindow_NWindow_y(fr_Env env, fr_Obj self) {
    return 0;
}
fr_Int vaseWindow_NWindow_w(fr_Env env, fr_Obj self) {
    return 0;
}
fr_Int vaseWindow_NWindow_h(fr_Env env, fr_Obj self) {
    return 0;
}
fr_Bool vaseWindow_NWindow_hasFocus(fr_Env env, fr_Obj self) {
    return 0;
}
void vaseWindow_NWindow_focus(fr_Env env, fr_Obj self) {
    return;
}
void vaseWindow_NWindow_textInput(fr_Env env, fr_Obj self, fr_Obj edit) {
    return;
}
void vaseWindow_NWindow_fileDialog(fr_Env env, fr_Obj self, fr_Obj accept, fr_Obj f, fr_Obj options) {
    return;
}
void vaseWindow_NWindow_finalize(fr_Env env, fr_Obj self) {
    return 0;
}