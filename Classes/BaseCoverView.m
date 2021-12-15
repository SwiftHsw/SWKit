//
//  BaseCoverView.m
//  MobileShop
//
//  Created by 黄世文 on 2021/11/16.
//

#import "BaseCoverView.h"


@implementation BaseCoverView

 
- (void)alertWithPopStyle:(LSTPopStyle)popStyle  hem:(LSTHemStyle)hem dismissStyle:(LSTDismissStyle)dismissStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    
    ATViewRadius(self, 5);
    
    //创建弹窗PopViiew 指定父容器self.view, 不指定默认是app window
    LSTPopView *popView = [LSTPopView initWithCustomView:self
                                              parentView:KeyWindow
                                                popStyle:popStyle
                                            dismissStyle:dismissStyle];
     
    //弹窗位置: 居中 贴顶 贴左 贴底 贴右
    popView.hemStyle = hem;
    LSTPopViewWK(popView)
    //点击背景触发
    popView.bgClickBlock = ^{
        [wk_popView dismiss];
    };
    //弹窗显示
    [popView pop];
}

- (void)dissMissAllAlert{
    [[LSTPopView getAllPopViewForParentView:KeyWindow] enumerateObjectsUsingBlock:^(LSTPopView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj dismiss];
    }];
   
}
- (UIView *)changeLine{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = SWColor(@"#E6E6E6");
    return lineView;;
}

@end
