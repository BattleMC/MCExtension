//
//  UIViewController+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MCExtension)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)MC_showPhotoLibrary;

- (void)MC_showCamera;

- (void)MC_showImagePickerWithSourceView:(UIView *)sourceView;

- (void)MC_showImagePickerWithSourceView:(UIView *)sourceView allowEdit:(BOOL)allowEdit;

- (void)MC_getPickerImage:(UIImage *)image;

///新增
- (void)MC_showImagePickerWithApplyLiveSourceView:(UIView *)sourceView selectRecommandImage:(void (^)(void))selectCommand;

@end

NS_ASSUME_NONNULL_END
