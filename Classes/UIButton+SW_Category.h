//
//  UIButton+SWEdgeInsets.h
//  SWUtils
//
//  CreSWed by  677676  on 2018/1/27.
//  Copyright © 2018年 艾腾软件.SW. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,SWImagePositionType) {
    SWImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    SWImagePositionTypeRight,  //图片在右，标题在左
    SWImagePositionTypeTop,    //图片在上，标题在下
    SWImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, SWEdgeInsetsType) {
    SWEdgeInsetsTypeTitle,//标题
    SWEdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, SWMarginType) {
    SWMarginTypeTop         ,
    SWMarginTypeBottom      ,
    SWMarginTypeLeft        ,
    SWMarginTypeRight       ,
    SWMarginTypeTopLeft     ,
    SWMarginTypeTopRight    ,
    SWMarginTypeBottomLeft  ,
    SWMarginTypeBottomRight
};

/**
 
 默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 
 if (button.width小于imageView上image的width){图像会被压缩，文字不显示}
 
 if (button.width < imageView.width + label.width){图像正常显示，文字显示不全}
 
 if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙}
 */


typedef void(^ButtonActionCallBack)(UIButton *button);

@interface UIButton (SW_Category)

/** 事件回调的block */
@property (nonatomic, copy) ButtonActionCallBack buttonEventsBlock;

/**
 添加按钮点击事件

 @param action 事件
 @param controlEvents 点击方式
 */
-(void)addCallBackAction:(ButtonActionCallBack)action
        forControlEvents:(UIControlEvents)controlEvents;

/**
 添加按钮点击事件

 @param action 事件
 */
-(void)addCallBackAction:(ButtonActionCallBack)action;

- (void)addTitle:(NSString *)title action:(ButtonActionCallBack)action;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(SWImagePositionType)type spacing:(CGFloat)spacing;

/**
 *  按钮只设置了title or image，该方法可以改变它们的位置
 *
 *  @param edgeInsetsType <#edgeInsetsType description#>
 *  @param marginType     <#marginType description#>
 *  @param margin         <#margin description#>
 */
- (void)setEdgeInsetsWithType:(SWEdgeInsetsType)edgeInsetsType marginType:(SWMarginType)marginType margin:(CGFloat)margin;

 


/**
 *  扩大或缩小 UIButton 的点击范围
 *
 *  @param top    向上增加的点击范围(注:top参数值为负数,则反方向减小点击范围)
 *
 *  @param right  向右增加的点击范围(注:right参数值为负数,则反方向减小点击范围)
 *
 *  @param bottom 向下增加的点击范围(注:bottom参数值为负数,则反方向减小点击范围)
 *
 *  @param left   向左增加的点击范围(注:left参数值为负数,则反方向减小点击范围)
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
