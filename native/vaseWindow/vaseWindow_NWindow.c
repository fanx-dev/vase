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

void vaseWindow_NGraphics_setNvgContext(fr_Env env, fr_Obj self, NVGcontext* r);

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

void drawFrame(fr_Env env, fr_Obj self, GLFWwindow* window, NVGcontext* vg, fr_Obj graphics) {
    int winWidth, winHeight;
    int fbWidth, fbHeight;
    float pxRatio;
    
    static fr_Method paintM;
    static fr_Field viewF;
    if (paintM == NULL) {
        fr_Type type = fr_getObjType(env, self);
        fr_Type viewType = fr_findType(env, "vaseWindow", "View");
        paintM = fr_findMethod(env, viewType, "onPaint");
        viewF = fr_findField(env, type, "_view");
    }

    glfwGetWindowSize(window, &winWidth, &winHeight);
    glfwGetFramebufferSize(window, &fbWidth, &fbHeight);
    // Calculate pixel ration for hi-dpi devices.
    pxRatio = (float)fbWidth / (float)winWidth;

    // Update and render
    glViewport(0, 0, fbWidth, fbHeight);

    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);

    nvgBeginFrame(vg, winWidth, winHeight, pxRatio);

    fr_Value value;
    fr_getInstanceField(env, self, viewF, &value);
    fr_callMethod(env, paintM, 2, value.h, graphics);

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
    fr_Obj graphics = fr_newObjS(env, "vaseWindow", "NGraphics", "make", 0);
    vaseWindow_NGraphics_setNvgContext(env, graphics, handle->nanovg);

    while (!glfwWindowShouldClose(window))
    {
        float ratio;
        int width, height;
        //mat4x4 m, p, mvp;

        glfwGetFramebufferSize(window, &width, &height);
        ratio = width / (float)height;

        drawFrame(env, self, window, handle->nanovg, graphics);

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
    double mx, my;
    struct Window* handle = getWindow(env, self);
    glfwGetCursorPos(handle->window, &mx, &my);
    return mx;
}
fr_Int vaseWindow_NWindow_y(fr_Env env, fr_Obj self) {
    double mx, my;
    struct Window* handle = getWindow(env, self);
    glfwGetCursorPos(handle->window, &mx, &my);
    return my;
}
fr_Int vaseWindow_NWindow_w(fr_Env env, fr_Obj self) {
    int winWidth, winHeight;
    struct Window* handle = getWindow(env, self);
    glfwGetWindowSize(handle->window, &winWidth, &winHeight);
    return winWidth;
}
fr_Int vaseWindow_NWindow_h(fr_Env env, fr_Obj self) {
    int winWidth, winHeight;
    struct Window* handle = getWindow(env, self);
    glfwGetWindowSize(handle->window, &winWidth, &winHeight);
    return winHeight;
}
fr_Bool vaseWindow_NWindow_hasFocus(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    int focused = glfwGetWindowAttrib(handle->window, GLFW_FOCUSED);
    return focused;
}
void vaseWindow_NWindow_focus(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    glfwFocusWindow(handle->window);
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