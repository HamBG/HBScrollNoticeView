//
//  ZHNoticeHeadLine.h
//  Koudaitong
//
//  Created by zhanghan on 16/11/8.
//  Copyright © 2016年 qima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^actionBlock)(NSInteger index);

@interface ZHNoticeHeadLine : UIView

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign) NSTimeInterval scrollDuration;
@property (nonatomic, assign) NSTimeInterval stayDuration;


/**
 image setting

 @param image image name
 @param frame frame
 */
- (void)setImage:(NSString *)image frame:(CGRect)frame;


/**
 three property setting

 @param bgColor   background color
 @param textColor text color
 @param textFont  text font
 */
- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont;


/**
 two timeInterval setting

 @param scrollDuration scroll duration
 @param stayDuration   stay duration
 */
- (void)setScrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration;


/**
 change the tapAction show or jump
 default is tap to stop

 @param action tapAction block code
 */
- (void)changeTapMarqueeAction:(actionBlock)action;


/**
 add the timer and start headline animation.
 */
- (void)start;


/**
 stop the timer.
 */
- (void)stop;


/**
 separate string to lines

 @param source input source
 @param font   target font size
 @param rect   seprate rect
 @return       array
 */
- (NSArray *)getSeparatedLinesFromString:(NSString *)source font:(UIFont *)font rect:(CGRect)rect;
@end
