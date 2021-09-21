//
//  main.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/20.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


void fr_init(int argc, const char* argv[]);

int main(int argc, char * argv[]) {
    
    fr_init(0, NULL);
    
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
