//
//  UIBarButtonItem+SWExtension.m
//  ATCloudCar
//
//  Created by Shiwen Huang on 2018/4/23.
//  Copyright © 2018年 ATEN. All rights reserved.
//

#import "UIBarButtonItem+SWExtension.h"
#import "SWKit.h"

@implementation UIBarButtonItem (SWExtension)

+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    tagButton.size = CGSizeMake(66/3, 66/3);
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}

+ (instancetype)itemWithNavImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    tagButton.size = CGSizeMake(50, 50);
    tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}


+ (instancetype)itemWithTitle:(NSString *)title ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [tagButton setTitle:title forState:UIControlStateNormal];
    UIColor *color = ([title isEqualToString:@"完成"] || [title isEqualToString:@"刷新"] || [title isEqualToString:@"返回"])  ? SWMainColor : [UIColor whiteColor];
    
    [tagButton setTitleColor:color forState:UIControlStateNormal];
    tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    tagButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if ([title isEqualToString:@"登录"] || [title isEqualToString:@"注册"]) {
         tagButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    if ([title isEqualToString:@"我的订单"] || [title isEqualToString:@"旗袍师"]) {
        tagButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [tagButton setTitleColor:SWMainColor forState:UIControlStateNormal];
    }
    
    
    
    tagButton.size = tagButton.currentImage.size;
    tagButton.width += title.length>=4?65:40;
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (IS_IPHONE_4_0) {
        tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [tagButton sizeToFit];
    return [[self alloc] initWithCustomView:tagButton];
}

- (BOOL)selected
{
    UIButton *button = self.customView;
    
    return button.selected;
}

- (void)setSelected:(BOOL)selected
{
    UIButton *button = self.customView;
    button.selected = selected;
}
@end
