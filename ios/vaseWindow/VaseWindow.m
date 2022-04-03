//
//  VaseWindow.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/20.
//

#import "VaseWindow.h"

void vaseWindow_NWindow_drawFrame(fr_Env env, fr_Obj self);
void vaseWindow_NWindow_fireMotionEvent(fr_Env env, fr_Obj self, fr_Obj event);
extern float desityScale;

@interface VaseWindow () {
    
}
@end

@implementation VaseWindow

- (instancetype)initWithObj: (fr_Obj)winObj {
    self = [super init];
    if (self != nil) {
        windowObj = winObj;
    }
    return self;
}

- (void)dealloc {
    fr_Env env = fr_getEnv(NULL);
    fr_deleteGlobalRef(env, windowObj);
    //[super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //printf("drawRect\n");
    fr_Env env = fr_getEnv(NULL);
    vaseWindow_NWindow_drawFrame(env, windowObj);
    
    if (fr_errOccurred(env)) {
        fr_Obj error = fr_getErr(env);
        fr_clearErr(env);
        fr_printErr(env, error);
    }
}

fr_Obj toFanTouch(fr_Env env, UIView *view, UITouch * touch, int type) {
    if (type == -1) {
        UITouchPhase phase = touch.phase;
        switch (phase) {
            case UITouchPhaseBegan:
                type = 0;
                break;
            case UITouchPhaseMoved:
                type = 2;
                break;
            case UITouchPhaseEnded:
                type = 1;
                break;
            case UITouchPhaseCancelled:
                type = 5;
                break;
            default:
                type = 7;
        }
    }
    
    static fr_Method makeM;
    static fr_Field pressureF;
    static fr_Field sizeF;
    static fr_Field xF;
    static fr_Field yF;
    static fr_Field pointerIdF;
    if (!makeM) {
        fr_Type type = fr_findType(env, "vaseWindow", "MotionEvent");
        makeM = fr_findMethod(env, type, "make");
        pressureF = fr_findField(env, type, "pressure");
        sizeF = fr_findField(env, type, "size");
        xF = fr_findField(env, type, "x");
        yF = fr_findField(env, type, "y");
        pointerIdF = fr_findField(env, type, "pointerId");
    }
    fr_Obj event = fr_callMethod(env, makeM, 1, (fr_Int)type).h;//fr_newObjS(env, "vaseWindow", "MotionEvent", "make", 1, (fr_Int)type);
    fr_Value value;
    value.f = touch.force;
    fr_setInstanceField(env, event, pressureF, &value);
    
    value.f = touch.majorRadius * desityScale;
    fr_setInstanceField(env, event, sizeF, &value);
    
    CGPoint pos = [touch locationInView:view];
    value.i = pos.x * desityScale;
    fr_setInstanceField(env, event, xF, &value);
    value.i = pos.y * desityScale;
    fr_setInstanceField(env, event, yF, &value);
    
    uint64_t pointerId = (uint64_t)touch;
    value.i = pointerId;
    fr_setInstanceField(env, event, pointerIdF, &value);
    return event;
}

fr_Obj fireTouchAll(UIView *view, NSSet<UITouch *> *touches, UIEvent* event, int type, fr_Obj winObj) {
    UITouch *touch = touches.anyObject;
    NSSet *all = event.allTouches;
    
    fr_Env env = fr_getEnv(NULL);
    fr_Obj mainE = toFanTouch(env, view, touch, type);
    fr_Obj list = fr_newObjS(env, "sys", "List", "make", 1, (fr_Int)(all.count));
    for (UITouch *t in all) {
        fr_Obj e = toFanTouch(env, view, t, -1);
        fr_callOnObj(env, list, "add", 1, e);
    }
    fr_Value value;
    value.h = list;
    fr_setFieldS(env, mainE, "pointers", value);
    
    vaseWindow_NWindow_fireMotionEvent(env, winObj, mainE);
    
    if (fr_errOccurred(env)) {
        fr_Obj error = fr_getErr(env);
        fr_clearErr(env);
        fr_printErr(env, error);
    }
    return mainE;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    fireTouchAll(self, touches, event, 0, windowObj);
    [self endEditing:YES];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    fireTouchAll(self, touches, event, 2, windowObj);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    fireTouchAll(self, touches, event, 1, windowObj);
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    fireTouchAll(self, touches, event, 5, windowObj);
}
- (void)onBack {
    fr_Env env = fr_getEnv(NULL);
    fr_Obj view = fr_callOnObj(env, windowObj, "view", 0).h;
    fr_callOnObj(env, view, "onBack", 0);
}

@end
