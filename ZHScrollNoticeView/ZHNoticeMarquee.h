//
//  ZHNoticeMarquee.h
//  Koudaitong
//
//  Created by zhanghan on 16/11/8.
//  Copyright © 2016年 qima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZHMarqueeSpeedLevel) {
    ZHMarqueeSpeedLevelFast       = 2,
    ZHMarqueeSpeedLevelMediumFast = 4,
    ZHMarqueeSpeedLevelMediumSlow = 6,
    ZHMarqueeSpeedLevelSlow       = 8,
};

@interface ZHNoticeMarquee : UIView

/**
 style is default, backgroundColor is white,textColor is black;

 @param frame frame
 @param speed ZHMarqueeSpeedLevel
 @param msg msg
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame speed:(ZHMarqueeSpeedLevel)speed Msg:(NSString *)msg ;

/**
 *  style is diy, backgroundColor and textColor can config
 *
 *  @param speed  you can set 2,4,6,8.  smaller is faster
 *  @param bgColor  backgroundColor
 *  @param txtColor textColor
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame speed:(ZHMarqueeSpeedLevel)speed Msg:(NSString *)msg bgColor:(UIColor *)bgColor txtColor:(UIColor *)txtColor;

/**
 *  you can change the tapAction show or jump, without this method default is tap to stop
 *
 *  @param action tapAction block code
 */
- (void)changeTapMarqueeAction:(void(^)())action;

/**
 change marqueeLabel 's font before start

 @param font
 */
- (void)changeMarqueeLabelFont:(UIFont *)font;

/**
 *  begin animate
 */
- (void)start;

/**
 *  pause
 */
- (void)stop;

/**
 *  will start with the point we stoped.
 */
- (void)restart;

@end
