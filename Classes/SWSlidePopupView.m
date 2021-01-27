//
//  SWSlidePopupView.m
//  SWSlidePopupView
//
//  Created by 帅到不行 on 2021/1/26.
//  Copyright © 2021 lity. All rights reserved.
//

#import "SWSlidePopupView.h"

@interface SWSlidePopupView() <UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIView *contentView;

/// 单击
@property (nonatomic, strong) UITapGestureRecognizer    *tapGesture;
/// 拖动
@property (nonatomic, strong) UIPanGestureRecognizer    *panGesture;
/// 是否拖动的为UIScrollView
@property (nonatomic, assign) BOOL                   isDragScrollView;

/// 记录拖动的视图是否为scrollView
@property (nonatomic, weak) UIScrollView                *scrollView;

///记录最后的拖动y值
@property (nonatomic, assign) CGFloat                   lastTransitionY;
@end


@implementation SWSlidePopupView

+(instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView *)contentView{
    
    return [[SWSlidePopupView alloc]initWithFrame:frame contentView:contentView];
}


- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView{
    if (self = [super initWithFrame:frame]) {
        self.contentView = contentView;
        
        //默认不展示内容视图
        CGRect contentFrame = contentView.frame;
        contentFrame.origin.y = frame.size.height;
        self.contentView.frame = contentFrame;
        [self addSubview:self.contentView];
        //添加手势
        
        [self addGestureRecognizer:self.tapGesture];
        [self addGestureRecognizer:self.panGesture];
        
        
    }
    return  self;
}

- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion{
    [fromView addSubview:self];
    [self showWithCompletion:completion];
    
}

#pragma mark - 重写手势代理

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    if (gestureRecognizer == self.panGesture) {
        //如果是拖动手势 遍历视图
        UIView *touchView = touch.view;
        while (touchView != nil) {
            if ([touchView isKindOfClass:[UIScrollView class]]) {
                self.scrollView = (UIScrollView *)touchView;
                self.isDragScrollView = YES;
                 break;
            }else if (touchView == self.contentView){
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
    }
    return  YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.tapGesture) {
        CGPoint point = [gestureRecognizer locationInView:self.contentView];
        if ([self.contentView.layer containsPoint:point] && gestureRecognizer.view == self) {
            return  NO;
        }else if (gestureRecognizer == self.panGesture){
            return  YES;
        }
    }
    return YES;
}
// 是否与其他手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    
    if (gestureRecognizer == self.panGesture) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
                return  YES;
            }
        }
    }
    return NO;
}
#pragma mark - HandleGesture
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    
    CGPoint point = [tapGesture  locationInView:self.contentView];
    //找到当前弹出的视图point位置
    if (![self.contentView.layer containsPoint:point] && tapGesture.view == self) {
        //消失
        [self dismiss];
    }
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint translation = [panGesture translationInView:self.contentView];
    if (self.isDragScrollView) {
           // 当UIScrollView在最顶部时，处理视图的滑动
        if (self.scrollView.contentOffset.y <= 0) {
            if (translation.y > 0) {
                self.scrollView.contentOffset = CGPointZero;
                self.scrollView.panGestureRecognizer.enabled = NO;
                self.isDragScrollView = NO;
                
                CGRect contentFrame = self.contentView.frame;
                contentFrame.origin.y += translation.y;
                self.contentView.frame = contentFrame;
                
            }
        }
    }else{
          
        CGFloat contenH = (self.frame.size.height - self.contentView.frame.size.height) ;
          CGRect contenFrame = self.contentView.frame;
        
        if (translation.y > 0) {
            // 向下拖拽
            contenFrame.origin.y += translation.y;
        }else if (translation.y < 0 && self.contentView.frame.origin.y > contenH){
            //向上拖拽
            contenFrame.origin.y = MAX((self.contentView.frame.origin.y + translation.y), contenH);
             
            
            //如果需要整块向上拖动 设置contenH 临界点即可，比如导航栏+状态栏高度 80
//            contenFrame.origin.y = MAX((self.contentView.frame.origin.y + translation.y), contenH);
//
//            NSLog(@"===%f",contenFrame.origin.y);
            
        }
         self.contentView.frame = contenFrame;
    }
    
    [panGesture setTranslation:CGPointZero inView:self.contentView];
    if (panGesture.state == UIGestureRecognizerStateEnded) {
         //结束拖拽 计算拖动的速度
        CGPoint velocity = [panGesture velocityInView:self.contentView];
         // 结束时的速度>0 滑动距离> 5 且UIScrollView滑动到最顶部
        if (velocity.y>0 && self.lastTransitionY >5 && !self.isDragScrollView ) {
            [self dismiss];
        }else{
            [self showWithCompletion:^{
                
            }];
        }
        
    }
    self.lastTransitionY = translation.y;
    
}
//弹出
- (void)showWithCompletion:(void (^)(void))completion{
    [UIView animateWithDuration:.25f animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.frame.size.height - frame.size.height;
        self.contentView.frame = frame;
    }completion:^(BOOL finished) {
        !completion ? : completion();
    }];
    
    
}
//移除
-(void)dismiss{
    
    [UIView animateWithDuration:.25f animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.frame.size.height ;
        self.contentView.frame = frame;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark - lazy

- (UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}
- (UIPanGestureRecognizer *)panGesture {
        if (!_panGesture) {
            _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
            _panGesture.delegate = self;
        }
        return _panGesture;
}
@end
