//
//  DJSEnglishCardImageView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSEnglishCardImageView.h"
#import <Masonry.h>
@implementation DJSEnglishCardImageView

//imageView 的 action: 就是一个方法 ：@seletor(clicked:) 这个方法里面具体的内容就是点击后该imageView进行高亮，并将其位置从左侧或者右侧切换到中间并且在移动的过程中均匀变大
//问题：应该怎么让其他的imageView联动切换？
//可以给所有imageView中的内容分别存储到数组的每个单元中向右移动时则显示在主界面上的(两个侧面小imageView与一个主iamgeView)共三个imageView的编号分别+1或-1

//原始尺寸
static CGRect oldFrame;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpeg"]];
        self.imageCardLabel = [[UILabel alloc] init];
        [self addSubview:self.imageCardLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.imageCardLabel.numberOfLines = 0;
    self.imageCardLabel.textAlignment = NSTextAlignmentCenter;
    self.imageCardLabel.text = @"Absence to love is what wind is to fire. It extinguishes the small; it inflames the great. (Roger de Bussy-Rabutin, French writer)";
    self.imageCardLabel.font = [UIFont systemFontOfSize:15];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [(NSObject *)self.target performSelectorInBackground:self.action withObject:self];
}

+ (void)scanBigImageWithImageView:(UIImageView *)currentImageview
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self scanBigImageWithImage:currentImageview.image frame:[currentImageview convertRect:currentImageview.bounds toView:window]];
    //convertRect:(CGRect) toView:(nullable UIView *)
    //算出currentImageview 相对于窗口的位置
}

/**
 浏览大图 - 如果图片不是在imageView上可用此方法.
 
 @param image 查看的图片对象
 @param pOldframe 当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值 [currentImageview convertRect:currentImageview.bounds toView:window];
 */
+ (void)scanBigImageWithImage:(UIImage *)image frame:(CGRect)pOldframe
{
    oldFrame = pOldframe;
    //当前视图
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundView.backgroundColor = [UIColor darkGrayColor];
    backGroundView.alpha = 0.0f;
    
    //将所有展示的imageView重新绘制到背景视图中
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:oldFrame];
//    UILabel * imageCardLabel = [[UILabel alloc] init];
//    imageCardLabel.numberOfLines = 0;
//    imageCardLabel.textAlignment = NSTextAlignmentCenter;
//    imageCardLabel.font = [UIFont systemFontOfSize:15];
//    imageCardLabel.text = @"Absence to love is what wind is to fire. It extinguishes the small; it inflames the great. (Roger de Bussy-Rabutin, French writer)";
//    [imageView addSubview:imageCardLabel];
//    [imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(imageView);
//    }];
    imageView.image = image;
    imageView.tag = 1024;
    [backGroundView addSubview:imageView];
    [window addSubview:backGroundView];
#pragma mark Request: 添加手势：放大后的图片单机则可返回原状 还需添加一个手势 或者：加一个导航栏 用push与pop???
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
//    tapGestureRecognizer.delegate = self;
    [backGroundView addGestureRecognizer:tapGestureRecognizer];
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
        //宽度设为屏幕宽度即可
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(0, y, width, height)];
        backGroundView.alpha = 1;
    } completion:^(BOOL finished) {
#pragma mark Request:添加关闭按钮和卡片Label
        UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelImageView:) forControlEvents:UIControlEventTouchUpInside];
        [backGroundView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backGroundView.mas_top).offset(15);
            make.left.mas_equalTo(backGroundView.mas_right).offset(-40);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        UILabel * imageCardLabel = [[UILabel alloc] init];
        imageCardLabel.numberOfLines = 0;
        imageCardLabel.textAlignment = NSTextAlignmentCenter;
        imageCardLabel.font = [UIFont systemFontOfSize:15];
        imageCardLabel.text = @"Absence to love is what wind is to fire. It extinguishes the small; it inflames the great. (Roger de Bussy-Rabutin, French writer)";
        [imageView addSubview:imageCardLabel];
        [imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageView);
        }];
#pragma mark:从背景视图移除手势
        [backGroundView removeGestureRecognizer:tapGestureRecognizer];
        
    }];
}

+ (void)cancelImageView:(UIButton *)cancelButton
{
    UIView * backGroundView = cancelButton.superview;
    UIImageView * imageView = [cancelButton.superview viewWithTag:1024];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        //[imageView setFrame:oldFrame];
        [backGroundView setAlpha:0];
    } completion:^(BOOL finished) {
        [imageView setFrame:oldFrame];
        //完成后的操作 把背景视图删除
        [backGroundView removeFromSuperview];
    }];
}

//判断该视图是否为父视图的子视图
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:touch.view.superview]) {
        return NO;
    }
    return YES;
}

/**
 *  恢复imageView原始尺寸
 *
 *
 */
+ (void)hideImageView:(UITapGestureRecognizer *)tap
{
    UIView * backGroundView = tap.view;
    //原始的imageView
    //查找tag值为1024的imageView 这个view就是带有图片的view
    UIImageView * imageView = [tap.view viewWithTag:1024];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        //[imageView setFrame:oldFrame];
        [backGroundView setAlpha:0];
    } completion:^(BOOL finished) {
        [imageView setFrame:oldFrame];
        //完成后的操作 把背景视图删除
        [backGroundView removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
