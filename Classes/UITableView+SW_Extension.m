//
//  UITableView+SW_Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UITableView+SW_Extension.h"
#import <objc/message.h>
#import "SWKit.h"
 

// 加载完数据的标记属性名
static NSString * const kSWTableViewPropertyInitFinish = @"kSWTableViewPropertyInitFinish";


@implementation UITableView (SW_Extension)

+ (void)load{
    
    static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           
           Method old_Method1 = class_getInstanceMethod(self, @selector(reloadData));
           Method new_Method1 = class_getInstanceMethod(self, @selector(sw_reloadData));
           method_exchangeImplementations(old_Method1, new_Method1);
           
           Method old_Method2 = class_getInstanceMethod(self, @selector(reloadSections:withRowAnimation:));
           Method new_Method2 = class_getInstanceMethod(self, @selector(sw_reloadSections:withRowAnimation:));
           method_exchangeImplementations(old_Method2, new_Method2);
           
           Method old_Method3 = class_getInstanceMethod(self, @selector(initWithFrame:style:));
           Method new_Method3 = class_getInstanceMethod(self, @selector(sw_initWithFrame:style:backView:));
           method_exchangeImplementations(old_Method3, new_Method3);
       });
    
    
}

- (instancetype)sw_initWithFrame:(CGRect)frame style:(UITableViewStyle)style backView:(UIView *)backView
{
    UITableView *tableView = [self sw_initWithFrame:frame style:style backView:backView];
    tableView.backView = backView;
    tableView.backgroundView = tableView.backView;
    tableView.canScrollBackView = YES;
    return tableView;
}

- (void)sw_reloadData
{
    [self sw_reloadData];
    
    //  忽略第一次加载
    if (![self isInitFinish])
    {
        [self havingData:YES];
        [self setIsInitFinish:YES];
        return ;
    }
    
    //  刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //是否数据为空
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger i = 0; i < numberOfSections; i++)
        {
            if (![self.ignoreSectionShowBackViewArr containsObject:[NSNumber numberWithInteger:i]])
            {
                NSInteger count = [self numberOfRowsInSection:i];
                if (count > 0)
                {
                    havingData = YES;
                    break;
                }
            }
        }
        [self havingData:havingData];
    });
}
- (void)havingData:(BOOL)isHave
{
    
    //当前是否有背景图
    if (![self.backgroundView isEqual:self.backView])
    {
        return ;
    }
    
    self.backView.hidden = isHave;
}

- (void)sw_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self sw_reloadData];
    
    //  忽略第一次加载
    if (![self isInitFinish])
    {
        [self havingData:YES];
        [self setIsInitFinish:YES];
        return ;
    }
    
    //  刷新完成之后检测数据量
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //是否数据为空
        NSInteger numberOfSections = [self numberOfSections];
        BOOL havingData = NO;
        for (NSInteger i = 0; i < numberOfSections; i++)
        {
            if (![self.ignoreSectionShowBackViewArr containsObject:[NSNumber numberWithInteger:i]])
            {
                NSInteger count = [self numberOfRowsInSection:i];
                if (count > 0)
                {
                    havingData = YES;
                    break;
                }
            }
        }
        [self havingData:havingData];
    });
}


/**
是否已经加载完成数据
*/
- (BOOL)isInitFinish{
    id obj = objc_getAssociatedObject(self, &kSWTableViewPropertyInitFinish);
    return obj;
}

/**
 设置已经加载完成数据了
 */
- (void)setIsInitFinish:(BOOL)finish {
    objc_setAssociatedObject(self, &kSWTableViewPropertyInitFinish, @(finish), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setUnShowBackView:(BOOL)unShowBackView{
    self.backView.hidden = unShowBackView;
    objc_setAssociatedObject(self, @selector(unShowBackView), @(unShowBackView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)unShowBackView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCanScrollBackView:(BOOL)canScrollBackView{
    objc_setAssociatedObject(self, @selector(canScrollBackView), @(canScrollBackView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canScrollBackView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

/*传入其他自定义的View*/
- (void)setBackView:(UIView *)backView
{
    objc_setAssociatedObject(self, @selector(backView), backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)backView
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setIgnoreSectionShowBackViewArr:(NSMutableArray<NSNumber *> *)ignoreSectionShowBackViewArr
{
    objc_setAssociatedObject(self, @selector(ignoreSectionShowBackViewArr), ignoreSectionShowBackViewArr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray<NSNumber *> *)ignoreSectionShowBackViewArr
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
