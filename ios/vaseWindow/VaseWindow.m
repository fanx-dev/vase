//
//  VaseWindow.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/20.
//

#import "VaseWindow.h"

void vaseWindow_NWindow_drawFrame(fr_Env env, fr_Obj self);

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
    fr_Env env = fr_getEnv(NULL);
    vaseWindow_NWindow_drawFrame(env, windowObj);
}
@end
