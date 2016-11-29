//
//  ViewController.m
//  ZHScrollNoticeView
//
//  Created by zhanghan on 2016/11/29.
//  Copyright © 2016年 zhanghan. All rights reserved.
//

#import "ViewController.h"
#import "ZHNoticeHeadLine.h"
#import "ZHNoticeMarquee.h"

#define  DEVICE_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define  DEVICE_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define  DATASTRING @"简单点说话size的方式简单点，递进的情绪请省略，你又不是个演员size别设计那些情节，没意见我只想看看你怎么圆，你难过的太表面，像没天赋 size 的演员，观众一眼能看见"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"跑马灯";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    ZHNoticeHeadLine *noticeLine = [[ZHNoticeHeadLine alloc]initWithFrame:CGRectMake(0, 100, DEVICE_WIDTH, 35)];
    [noticeLine setBgColor:[UIColor grayColor] textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:14.0]];
    [noticeLine setImage:@"speaker.png" frame:CGRectMake(10, 7, 20, 20)];
    [noticeLine setScrollDuration:1.0 stayDuration:3.0];
    noticeLine.messageArray = [noticeLine getSeparatedLinesFromString:DATASTRING font:[UIFont systemFontOfSize:15.0f] rect:CGRectMake(0, 0, DEVICE_WIDTH-35, 35)];
    [self.view addSubview:noticeLine];
    [noticeLine start];
    
    ZHNoticeMarquee *mar = [[ZHNoticeMarquee alloc]initWithFrame:CGRectMake(0, 200, DEVICE_WIDTH, 35) speed:4 Msg:DATASTRING bgColor:[UIColor greenColor] txtColor:[UIColor blackColor]];
    [mar changeMarqueeLabelFont:[UIFont systemFontOfSize:20.0f]];
    [self.view addSubview:mar];
    [mar start];

}

@end
