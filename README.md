# ZHScrollNoticeView
Contain Horizontal scroll bar and Vertical scroll bar. 

#How to Use
```
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
```
