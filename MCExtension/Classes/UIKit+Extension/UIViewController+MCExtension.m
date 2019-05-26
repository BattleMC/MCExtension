//
//  UIViewController+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIViewController+MCExtension.h"

#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "UIAlertController+MCExtension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MCMacro.h"
@implementation UIViewController (MCExtension)

- (void)MC_showPhotoLibrary
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私-照片”选项中，允许大师说访问您的手机相册"];
        [self presentViewController:confirm animated:YES completion:nil];
        return;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)MC_showCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
    {
        UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私”选项中，允许大师说访问您的摄像头"];
        [self presentViewController:confirm animated:YES completion:nil];
        return;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)MC_showImagePickerWithSourceView:(UIView *)sourceView
{
    [self MC_showImagePickerWithSourceView:sourceView allowEdit:YES];
}

- (void)MC_showImagePickerWithSourceView:(UIView *)sourceView allowEdit:(BOOL)allowEdit
{
    @weakify(self);
    UIAlertController *alert = [UIAlertController MC_actionSheetWithTitle:nil message:nil btnTitles:@[@"相册",@"相机"] clickBtnAtIndex:^(NSInteger index) {
        @strongify(self);
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = allowEdit;
        imagePicker.delegate = self;
        if (index == 0) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私-照片”选项中，允许大师说访问您的手机相册"];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else if (index == 1){
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
            {
                UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私”选项中，允许大师说访问您的摄像头"];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    if (IS_IPAD) {
        alert.popoverPresentationController.sourceView = sourceView;
        alert.popoverPresentationController.sourceRect = sourceView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
}

//MARK:新增
- (void)MC_showImagePickerWithApplyLiveSourceView:(UIView *)sourceView selectRecommandImage:(nonnull void (^)(void))selectCommand{
    @weakify(self);
    UIAlertController *alert = [UIAlertController MC_actionSheetWithTitle:nil message:nil btnTitles:@[@"相册",@"相机",@"官方推荐图"] clickBtnAtIndex:^(NSInteger index) {
        @strongify(self);
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        if (index == 0) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私-照片”选项中，允许大师说访问您的手机相册"];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else if (index == 1){
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
            {
                UIAlertController *confirm = [UIAlertController MC_alertWithOKButtonWithTitle:@"提示" message:@"请前往“设置-隐私”选项中，允许大师说访问您的摄像头"];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else if (index == 2) {
            selectCommand();
        }
    }];
    if (IS_IPAD) {
        alert.popoverPresentationController.sourceView = sourceView;
        alert.popoverPresentationController.sourceRect = sourceView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self MC_getPickerImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//- (void)MC_getPickerImage:(UIImage *)image
//{
//
//}

@end
