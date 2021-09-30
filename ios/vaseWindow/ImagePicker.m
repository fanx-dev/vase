//
//  ImagePicker.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/9/30.
//

#include "ImagePicker.h"

@implementation ImagePicker

- (instancetype)initWith: (UIViewController*)viewController {
    self = [super init];
    if (self != nil) {
        self.viewController = viewController;
    }
    return self;
}

- (void)selectPhoto {
    NSString *camera = @"Camera";
    NSString *album = @"Album";
    NSArray*languages = [NSLocale preferredLanguages];
    NSString*currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage hasPrefix:@"zh"]) {
        camera = @"照相机";
        album = @"相册";
    }
    
    UIAlertController *alterConroller = [UIAlertController alertControllerWithTitle:@"select" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:camera style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:album style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }];
    [alterConroller addAction:albumAction];
    [alterConroller addAction:cameraAction];
    [self.viewController presentViewController:alterConroller animated:YES completion:nil];
}

- (void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

- (void)openAlbum{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (!image) {
            image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        }
        
        UIGraphicsImageRendererFormat *format = image.imageRendererFormat;
        
        NSString *tempImageName;
        NSData *data;
        if (format.opaque) {
            data = UIImageJPEGRepresentation(image, 1.0);
            tempImageName = @"/image.jpg";
        }
        else {
            data = UIImagePNGRepresentation(image);
            tempImageName = @"/image.png";
        }

        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:tempImageName] contents:data attributes:nil];
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, tempImageName];
        
        if (self.callback) {
            self.callback(self.filePath);
        }

        [picker dismissModalViewControllerAnimated:YES];
    }
}
@end
