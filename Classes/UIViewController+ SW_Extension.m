//
//  UIViewController+SW_Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UIViewController+SW_Extension.h"
#import "SWKit.h"
#import <objc/message.h>

 

@implementation UIViewController (Extension)


+ (void)load{
     
     
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         
        Method old_method1 = class_getInstanceMethod(self, @selector(viewDidAppear:));
        Method new_method1 = class_getInstanceMethod(self, @selector(sw_viewDidAppear:));
        method_exchangeImplementations(old_method1, new_method1);
        
        Method old_method2 = class_getInstanceMethod(self, @selector(viewWillLayoutSubviews));
        Method new_method2 = class_getInstanceMethod(self, @selector(sw_viewWillLayoutSubviews));
        method_exchangeImplementations(old_method2, new_method2);
        
        Method old_method3 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method new_method3 = class_getInstanceMethod(self, @selector(sw_viewWillAppear:));
        method_exchangeImplementations(old_method3, new_method3);
        
        Method old_method4 = class_getInstanceMethod(self, @selector(viewDidLayoutSubviews));
        Method new_method4 = class_getInstanceMethod(self, @selector(sw_viewDidLayoutSubviews));
        method_exchangeImplementations(old_method4, new_method4);
        
        
        
    });
    
    
}


- (void)sw_viewWillLayoutSubviews{
    [self sw_viewWillLayoutSubviews];
    [self leftItemSpacing:self.sw_leftNavItemSpacing];
    [self rightItemSpacing:self.sw_rightNavItemSpacing];
}

- (void)sw_viewDidLayoutSubviews{
    [self sw_viewDidLayoutSubviews];
    [self leftItemSpacing:self.sw_leftNavItemSpacing];
    [self rightItemSpacing:self.sw_rightNavItemSpacing];
}

- (void)sw_viewDidAppear:(BOOL)animated{
    [self sw_viewDidAppear:animated];
    [self leftItemSpacing:self.sw_leftNavItemSpacing];
    [self rightItemSpacing:self.sw_rightNavItemSpacing];
}

- (void)sw_viewWillAppear:(BOOL)animated{
    [self sw_viewWillAppear:animated];
    [self leftItemSpacing:self.sw_leftNavItemSpacing];
    [self rightItemSpacing:self.sw_rightNavItemSpacing];
}

- (void)setSw_leftNavItemSpacing:(CGFloat)sw_leftNavItemSpacing{
    objc_setAssociatedObject(self, @selector(sw_leftNavItemSpacing), @(sw_leftNavItemSpacing), OBJC_ASSOCIATION_RETAIN);
     
}

- (CGFloat)sw_leftNavItemSpacing{
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
    
}

- (void)setSw_rightNavItemSpacing:(CGFloat)sw_rightNavItemSpacing{
    objc_setAssociatedObject(self, @selector(sw_rightNavItemSpacing), @(sw_rightNavItemSpacing), OBJC_ASSOCIATION_RETAIN);
     
}

- (CGFloat)sw_rightNavItemSpacing{
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
    
}


- (void)leftItemSpacing:(CGFloat)spacing{
    //系统大于11.0
    if ([[UIDevice currentDevice].systemVersion floatValue] > 11.0)
    {
        for (UIView *view in self.navigationController.navigationBar.subviews)
        {
            if ([view isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")])
            {
                if (view.subviews.count >= 1 && self.navigationItem.leftBarButtonItems.count != 0)
                {
                    UIView *leftStaticView = view.subviews[0];
                    for (NSLayoutConstraint *constraint in view.constraints)
                    {
                        if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                             constraint.firstAttribute == NSLayoutAttributeTrailing))
                        {
                            [view removeConstraint:constraint];
                        }
                    }
                    [view addConstraint:[NSLayoutConstraint constraintWithItem:leftStaticView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:spacing]];
                    return;
                }
            }
        }
    }
    //系统11.0之前
    else{
        if (self.navigationItem.leftBarButtonItems.firstObject.systemItem != UIBarButtonSystemItemFixedSpace &&
            self.navigationItem.leftBarButtonItems.count != 0)
        {
            UIBarButtonItem *spacingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spacingItem.width = spacing - 16;
            NSMutableArray<UIBarButtonItem *> *arrs = [self.navigationItem.leftBarButtonItems mutableCopy];
            [arrs insertObject:spacingItem atIndex:0];
            self.navigationItem.leftBarButtonItems = arrs;
        }
    }
}
- (void)rightItemSpacing:(CGFloat)spacing{
    //系统大于11.0
    if ([[UIDevice currentDevice].systemVersion floatValue] > 11.0)
    {
        for (UIView *view in self.navigationController.navigationBar.subviews)
        {
            if ([view isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")])
            {
                if (view.subviews.count >= 1 && self.navigationItem.rightBarButtonItems.count != 0)
                {
                    NSInteger index=  self.navigationItem.leftBarButtonItems.count == 0 ? 0 : 1;
                    UIView *rightStaticView = view.subviews[index];
                    for (NSLayoutConstraint *constraint in view.constraints)
                    {
                        if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                             constraint.firstAttribute == NSLayoutAttributeTrailing))
                        {
                            [view removeConstraint:constraint];
                        }
                    }
                    [view addConstraint:[NSLayoutConstraint constraintWithItem:rightStaticView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:spacing * -1]];
                    return;
                }
            }
        }
    }
    //系统11.0之前
    else{
        if (self.navigationItem.rightBarButtonItems.firstObject.systemItem != UIBarButtonSystemItemFixedSpace &&
            self.navigationItem.rightBarButtonItems.count != 0)
        {
            UIBarButtonItem *spacingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spacingItem.width = spacing - 16;
            NSMutableArray<UIBarButtonItem *> *arrs = [self.navigationItem.rightBarButtonItems mutableCopy];
            [arrs insertObject:spacingItem atIndex:0];
            self.navigationItem.rightBarButtonItems = arrs;
        }
    }
}

- (void)takePhotoForCamera{
     [self takePhotoForCameraWithEditing:NO];
}

- (void)takePhotoForCameraWithEditing:(BOOL)edit{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        imagePicker.allowsEditing = edit;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [SWAlertViewController showInController:self
                                          title:@"提示" message:@"该设备暂不支持拍照" cancelButton:@"" other:@"确定" completionHandler:^(SWAlertButtonStyle buttonStyle) {
            
        }];
        
       
    }
    
}

-(void)takePhotoForLibraryWithEditing:(BOOL)edit{
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
       pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       pick.delegate = self;
       pick.allowsEditing = edit;
       [pick.navigationBar setTintColor:[UIColor blackColor]];
       [self presentViewController:pick animated:YES completion:nil];
}
@end



@implementation UIBarButtonItem (Extension)


+ (void)load{
     
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          
        Method old_method1 = class_getInstanceMethod(self, @selector(initWithBarButtonSystemItem:target:action:));
        Method new_method1 = class_getInstanceMethod(self, @selector(sw_initWithBarButtonSystemItem:target:action:));
         method_exchangeImplementations(old_method1, new_method1);
               
    });
    
    
}
-(instancetype)sw_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                       target:(nullable id)target
                                       action:(nullable SEL)action{
    self.systemItem = systemItem;
    return [self sw_initWithBarButtonSystemItem:systemItem target:target action:action];
}


- (void)setSystemItem:(UIBarButtonSystemItem)systemItem{
    objc_setAssociatedObject(self, @selector(systemItem), @(systemItem), OBJC_ASSOCIATION_RETAIN);
}

- (UIBarButtonSystemItem)systemItem{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
@end
