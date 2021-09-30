//
//  ImagePicker.h
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/30.
//

#ifndef ImagePicker_h
#define ImagePicker_h


#import <UIKit/UIKit.h>


@interface ImagePicker : UIResponder <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSString* filePath;
@property (strong, nonatomic) void (^callback)(NSString * filePath);

- (instancetype)initWith: (UIViewController*)viewController;
- (void)selectPhoto;
@end

#endif /* ImagePicker_h */
