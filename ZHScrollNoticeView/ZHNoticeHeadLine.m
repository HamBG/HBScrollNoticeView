//
//  ZHNoticeHeadLine.m
//  Koudaitong
//
//  Created by zhanghan on 16/11/8.
//  Copyright © 2016年 qima. All rights reserved.
//

#import "ZHNoticeHeadLine.h"
#import <CoreText/CoreText.h>
#define kSXLineMargin 35

typedef NS_ENUM(NSInteger, ZHMarqueeTapMode) { ZHMarqueeTapForMove = 1, ZHMarqueeTapForAction = 2 };

@interface ZHNoticeHeadLine ()
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, assign) NSInteger messageIndex;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) actionBlock tapAction;
@property (nonatomic, assign) ZHMarqueeTapMode tapMode;
@end

@implementation ZHNoticeHeadLine

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
        self.h = frame.size.height;
        self.w = frame.size.width;
        UILabel *label1 =
        [[UILabel alloc] initWithFrame:CGRectMake(kSXLineMargin, 0, _w - kSXLineMargin - 15, _h)];
        UILabel *label2 =
        [[UILabel alloc] initWithFrame:CGRectMake(kSXLineMargin, _h, _w - kSXLineMargin - 15, _h)];
        self.label1 = label1;
        self.label2 = label2;
        [self addSubview:label1];
        [self addSubview:label2];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setImage:(NSString *)image frame:(CGRect)frame {
    _headImageView.image = [UIImage imageNamed:image];
    _headImageView.frame = frame;
}

#pragma mark - animate
- (void)scrollAnimate {
    CGRect rect1 = self.label1.frame;
    CGRect rect2 = self.label2.frame;
    rect1.origin.y -= _h;
    rect2.origin.y -= _h;
    [UIView animateWithDuration:_scrollDuration
    animations:^{
        self.label1.frame = rect1;
        self.label2.frame = rect2;
    }
    completion:^(BOOL finished) {
        [self checkLabelFrameChange:self.label1];
        [self checkLabelFrameChange:self.label2];
    }];
}

- (void)checkLabelFrameChange:(UILabel *)label {
    if (label.frame.origin.y < -10) {
        CGRect rect = label.frame;
        rect.origin.y = _h;
        label.frame = rect;
        label.text = self.messageArray[self.messageIndex];
        if (self.messageIndex == self.messageArray.count - 1) {
            self.messageIndex = 0;
        } else {
            self.messageIndex += 1;
        }
    }
}

- (void)start {
    if (self.timer) {
        return;
    }
    if (self.messageArray.count < 2)
        return;
    NSTimer *timer = [NSTimer timerWithTimeInterval:_stayDuration
                                             target:self
                                           selector:@selector(scrollAnimate)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setMessageArray:(NSArray *)messageArray {
    _messageArray = messageArray;
    if (self.messageArray.count > 2) {
        self.label1.text = self.messageArray[0];
        self.label2.text = self.messageArray[1];
        self.messageIndex = 2;
    } else if (self.messageArray.count == 1) {
        self.label1.text = self.messageArray[0];
    } else if (self.messageArray.count == 2) {
        self.label1.text = self.messageArray[0];
        self.label2.text = self.messageArray[1];
        self.messageIndex = 0;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label1.textColor = textColor;
    self.label2.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.label1.font = textFont;
    self.label2.font = textFont;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setScrollDuration:(NSTimeInterval)scrollDuration {
    _scrollDuration = scrollDuration;
}

- (void)setStayDuration:(NSTimeInterval)stayDuration {
    _stayDuration = stayDuration;
}

- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont {
    self.bgColor = bgColor;
    self.textColor = textColor;
    self.textFont = textFont;
}

- (void)setScrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration {
    self.scrollDuration = scrollDuration;
    self.stayDuration = stayDuration;
}

- (void)changeTapMarqueeAction:(actionBlock)action {
    self.tapAction = action;
    self.tapMode = ZHMarqueeTapForAction;
}

- (NSArray *)getSeparatedLinesFromString:(NSString *)source font:(UIFont *)font rect:(CGRect)rect {
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:source];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge id)myFont
                   range:NSMakeRange(0, attStr.length)];

    CTFramesetterRef frameSetter =
    CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 100000));

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);

    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];

    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);

        NSString *lineString = [source substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

@end
