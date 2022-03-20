//
//  VaseWindow.h
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/20.
//

#ifndef VaseWindow_h
#define VaseWindow_h
#import <UIKit/UIKit.h>
#include "fni_ext.h"

@interface VaseWindow : UIView {
    fr_Obj windowObj;
}

- (instancetype)initWithObj: (fr_Obj)winObj;

- (void)onBack;

@end

#endif /* VaseWindow_h */
