//
//  DJSDisplayerView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/9.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSDisplayerView.h"
#import <CoreText/CoreText.h>
#import "DJSCoreTextLinkData.h"
@implementation DJSDisplayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setGestureEvent];
    }
    return self;
}

- (void)setGestureEvent
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClickedEvent:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - Request 手势的点击事件
- (void)tapGestureClickedEvent:(UITapGestureRecognizer *)tap
{
    //得到点击点所在位置
    CGPoint point = [tap locationInView:self];
    NSLog(@"11111111111111111111");
    ///判断是否点击在文字上 点击到了才会给弹窗中出现的文字赋值
    DJSCoreTextLinkData * linkData = [DJSCoreTextLinkData touchLinkView:self atPoint:point data:self.data];
    
    if (linkData != nil) {
#pragma mark Request 新需求:想点击不同的文字 出现的弹窗上
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:linkData.urlString delegate:nil cancelButtonTitle:@"OK222" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用CGAffineTransformIdentity属性可以还原由于Transform而发生的改变，换句话说所有Transform发生的改变都会被还原
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    if (self.data) {
        //将文字绘制在上下文中
        CTFrameDraw(self.data.ctFrame, context);
    }
}

- (void)setData:(DJSCoreTextData *)data
{
    if (_data != data) {
        _data = data;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.data.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
