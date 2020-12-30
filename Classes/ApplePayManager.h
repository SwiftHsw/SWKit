//
//  ApplePayManager.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/29.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


//支付错误类型
typedef NS_ENUM(NSInteger, SWApplePayErrorCode){
    SWApplePaySuccess,//成功
    SWApplePayErrorCodeSysVersionLow,//系统版本太低，系统版本要在9.0级以上
    SWApplePayErrorCodeUnBingBankCard,//没有绑定银行卡
};

typedef void(^payCompleteCallback)(SWApplePayErrorCode errCode);


@interface ApplePayManager : NSObject

- (void)payWithMerchantId:(NSString *)merchantId
                 viewCtrl:(UIViewController *)viewCtrl complete:(payCompleteCallback)callback;

@end

NS_ASSUME_NONNULL_END
