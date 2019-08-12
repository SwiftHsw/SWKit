//
//  UIButton+ATEdgeInsets.m
//  ATUtils
//
//  Created by  677676  on 2018/1/27.
//  Copyright © 2018年 艾腾软件.SW. All rights reserved.
//

#import "UIButton+SWEdgeInsets.h"

@implementation UIButton (SWEdgeInsets)

- (void)setImagePositionWithType:(ATImagePositionType)type spacing:(CGFloat)spacing {
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGSize titleSize = [self sizeForText:[self titleForState:UIControlStateNormal] font:self.titleLabel.font size:CGSizeMake(HUGE, HUGE) mode:self.titleLabel.lineBreakMode];
    
    if (self.titleLabel.adjustsFontSizeToFitWidth && (type == ATImagePositionTypeLeft || type == ATImagePositionTypeRight)) {
        self.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    
    switch (type) {
        case ATImagePositionTypeLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            break;
        }
        case ATImagePositionTypeRight: {
            if (!CGRectEqualToRect(self.frame, CGRectZero)) {
                /**
                 这里需要真实的frame，autolayout通过下列方法可以拿到:
                 1. layoutSubViews
                 2. viewDidLayoutSubviews
                 3. 父view调用layoutIfNeeded
                 */
                CGFloat titleMaxHeight;
                NSLineBreakMode lineBreakMode = self.titleLabel.lineBreakMode;
                if (lineBreakMode == NSLineBreakByWordWrapping || lineBreakMode == NSLineBreakByCharWrapping) {
                    titleMaxHeight = HUGE;
                } else {
                    titleMaxHeight = self.titleLabel.font.pointSize;
                }
                
                CGSize titleMaxSize = CGSizeMake(CGRectGetWidth(self.frame) - (imageSize.width + spacing), titleMaxHeight);
                
                titleSize = [self sizeForText:[self titleForState:UIControlStateNormal] font:self.titleLabel.font size:titleMaxSize mode:self.titleLabel.lineBreakMode];
            }
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width + spacing);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, - titleSize.width);
            break;
        }
        case ATImagePositionTypeTop: {
            // lower the text and push it left so it appears centered
            //  below the image
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0);
            
            // raise the image and push it right so it appears centered
            //  above the text
            self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0, - titleSize.width);
            break;
        }
        case ATImagePositionTypeBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(- (imageSize.height + spacing), - imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, - (titleSize.height + spacing), - titleSize.width);
            break;
        }
    }
}

 

- (void)setEdgeInsetsWithType:(ATEdgeInsetsType)edgeInsetsType marginType:(ATMarginType)marginType margin:(CGFloat)margin {
    CGSize itemSize = CGSizeZero;
    if (edgeInsetsType == ATEdgeInsetsTypeTitle) {
        itemSize = [self sizeForText:[self titleForState:UIControlStateNormal] font:self.titleLabel.font size:CGSizeMake(HUGE, HUGE) mode:self.titleLabel.lineBreakMode];
    } else {
        itemSize = [self imageForState:UIControlStateNormal].size;
    }
    
    CGFloat horizontalDelta = (CGRectGetWidth(self.frame) - itemSize.width) / 2.f - margin;
    CGFloat vertivalDelta = (CGRectGetHeight(self.frame) - itemSize.height) / 2.f - margin;
    
    NSInteger horizontalSignFlag = 1;
    NSInteger verticalSignFlag = 1;
    
    switch (marginType) {
        case ATMarginTypeTop: {
            horizontalSignFlag = 0;
            verticalSignFlag = - 1;
            break;
        }
        case ATMarginTypeBottom: {
            horizontalSignFlag = 0;
            verticalSignFlag = 1;
            break;
        }
        case ATMarginTypeLeft: {
            horizontalSignFlag = - 1;
            verticalSignFlag = 0;
            break;
        }
        case ATMarginTypeRight: {
            horizontalSignFlag = 1;
            verticalSignFlag = 0;
            break;
        }
        case ATMarginTypeTopLeft: {
            horizontalSignFlag = - 1;
            verticalSignFlag = - 1;
            break;
        }
        case ATMarginTypeTopRight: {
            horizontalSignFlag = 1;
            verticalSignFlag = - 1;
            break;
        }
        case ATMarginTypeBottomLeft: {
            horizontalSignFlag = - 1;
            verticalSignFlag = 1;
            break;
        }
        case ATMarginTypeBottomRight: {
            horizontalSignFlag = 1;
            verticalSignFlag = 1;
            break;
        }
    }
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(vertivalDelta * verticalSignFlag, horizontalDelta * horizontalSignFlag, - vertivalDelta * verticalSignFlag, - horizontalDelta * horizontalSignFlag);
    if (edgeInsetsType == ATEdgeInsetsTypeTitle) {
        self.titleEdgeInsets = edgeInsets;
    } else {
        self.imageEdgeInsets = edgeInsets;
    }
}


#pragma mark - Drawing
- (CGSize)sizeForText:(NSString *)text font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [text sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

@end
