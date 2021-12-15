//
//  BaseCoverView.h
//  MobileShop
//
//  Created by 黄世文 on 2021/11/16.
//

#import <UIKit/UIKit.h>
#import "SWKit.h"
#import <LSTPopView/LSTPopView.h>

NS_ASSUME_NONNULL_BEGIN

 
@interface BaseCoverView : UIView

 
- (void)alertWithPopStyle:(LSTPopStyle)popStyle  hem:(LSTHemStyle)hem dismissStyle:(LSTDismissStyle)dismissStyle;

- (void)dissMissAllAlert;

- (UIView *)changeLine;

@end

NS_ASSUME_NONNULL_END
