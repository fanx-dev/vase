//
//  ViewController.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/20.
//

#import "ViewController.h"
#import "VaseWindow.h"
#include "temp/baseTest.h"
void vase_Window_setUIViewController(UIViewController *ctrl);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    fr_Env env = fr_getEnv(NULL);
    baseTest_init__(env);
    vase_Window_setUIViewController(self);
    baseTest_Main_main(env);
    if (env->error) {
        fr_Obj error = env->error;
        fr_clearErr(env);
        sys_Err_trace(env, error);
    }
}


@end
