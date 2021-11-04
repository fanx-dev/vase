#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

#include <stdlib.h>
#include <stdio.h>
#import "VaseWindow.h"
#include "ImagePicker.h"

void vaseWindow_NGraphics_setContext(fr_Env env, fr_Obj self, fr_Int r);

float desityScale = 1;
UIViewController *g_controller;

struct Window {
    VaseWindow* window;
    fr_Obj graphics;
};

void vase_Window_setUIViewController(UIViewController *ctrl) {
    g_controller = ctrl;
}

static struct Window* getWindow(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    struct Window* raw = (struct Window*)(val.i);
    return raw;
}

VaseWindow* vase_Window_getWindow(fr_Env env, fr_Obj self) { return getWindow(env, self)->window; }

static void setWindow(fr_Env env, fr_Obj self, struct Window* r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

void vaseWindow_NWindow_repaint(fr_Env env, fr_Obj self, fr_Obj dirty) {
    struct Window* handle = getWindow(env, self);
    //[handle->window setNeedsDisplay];
    [handle->window performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
    return;
}


void vaseWindow_NWindow_drawFrame(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    fr_Obj graphics = handle->graphics;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1/desityScale, 1/desityScale);
    
    if (graphics == NULL) {
        graphics = fr_newObjS(env, "vaseWindow", "NGraphics", "make", 1, (fr_Int)ctx);
        graphics = fr_newGlobalRef(env, graphics);
        handle->graphics = graphics;
    }
    else {
        vaseWindow_NGraphics_setContext(env, graphics, (fr_Int)ctx);
    }
    static fr_Method paintM;
    static fr_Field viewF;
    if (paintM == NULL) {
        fr_Type type = fr_getObjType(env, self);
        fr_Type viewType = fr_findType(env, "vaseWindow", "View");
        paintM = fr_findMethod(env, viewType, "onPaint");
        viewF = fr_findField(env, type, "_view");
    }
    
    
    fr_Value value;
    fr_getInstanceField(env, self, viewF, &value);
    fr_callMethod(env, paintM, 2, value.h, graphics);
    CGContextRestoreGState(ctx);
}

void vaseWindow_NWindow_show(fr_Env env, fr_Obj self, fr_Obj size) {
    struct Window* handle = (struct Window*)calloc(1, sizeof(struct Window));
    
    desityScale = [[UIScreen mainScreen] scale];

    handle->window = [[VaseWindow alloc] initWithObj: fr_newGlobalRef(env, self)];
    setWindow(env, self, handle);
    handle->graphics = NULL;
    
    
    CGRect frame = g_controller.view.bounds;
    UIEdgeInsets insets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
    frame.origin.x += insets.left;
    frame.origin.y += insets.top;
    frame.size.width -= insets.left + insets.right;
    frame.size.height -= insets.top + insets.bottom;
    handle->window.frame = frame;
    [g_controller.view addSubview:handle->window];
}

fr_Int vaseWindow_NWindow_x(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    return [handle->window frame].origin.x * desityScale;
}
fr_Int vaseWindow_NWindow_y(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    return [handle->window frame].origin.y * desityScale;
}
fr_Int vaseWindow_NWindow_w(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    int winWidth = [handle->window frame].size.width * desityScale;
    return winWidth;
}
fr_Int vaseWindow_NWindow_h(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    int winHeight = [handle->window frame].size.height * desityScale;
    return winHeight;
}
fr_Bool vaseWindow_NWindow_hasFocus(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    return [handle->window isFocused];
}
void vaseWindow_NWindow_focus(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    [handle->window setNeedsFocusUpdate];
    [handle->window updateFocusIfNeeded];
}

static ImagePicker *file_picker;
static fr_Obj file_callback;

void vaseWindow_NWindow_fileDialog(fr_Env env, fr_Obj self, fr_Obj accept, fr_Obj f, fr_Obj options) {
    ImagePicker *picker = [[ImagePicker alloc]initWith:g_controller];
    file_picker = picker;
    file_callback = fr_newGlobalRef(env, f);
    picker.callback = ^(NSString * filepath) {
        fr_Obj path = fr_newStrUtf8(env, filepath.UTF8String);
        fr_Obj list = fr_callMethodS(env, "sys", "List", "make", 1, (fr_Int)1).h;
        fr_Obj file = fr_callMethodS(env, "std", "File", "os", 1, path).h;
        fr_callOnObj(env, list, "add", 1, file);
        fr_callOnObj(env, file_callback, "call", 1, list);
        
        //cleanup
        file_picker.callback = nil;
        file_picker = nil;
        fr_deleteGlobalRef(env, file_callback);
        file_callback = NULL;
    };
    [picker selectPhoto];
    return;
}
void vaseWindow_NWindow_finalize(fr_Env env, fr_Obj self) {
    struct Window* handle = getWindow(env, self);
    fr_deleteGlobalRef(env, handle->graphics);
    handle->window = NULL;
    handle->graphics = NULL;
    return;
}
void vaseWindow_NWindow_fireMotionEvent(fr_Env env, fr_Obj self, fr_Obj event) {
    static fr_Method paintM;
    static fr_Field viewF;
    if (paintM == NULL) {
        fr_Type type = fr_getObjType(env, self);
        fr_Type viewType = fr_findType(env, "vaseWindow", "View");
        paintM = fr_findMethod(env, viewType, "onMotionEvent");
        viewF = fr_findField(env, type, "_view");
    }

    fr_Value value;
    fr_getInstanceField(env, self, viewF, &value);
    fr_callMethod(env, paintM, 2, value.h, event);
}
