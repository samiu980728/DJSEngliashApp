//
//  DJSEnglishCardImageView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSEnglishCardImageView.h"
#import <Masonry.h>
#import "DJSDisplayerView.h"
#import "DJSCTFrameParserConfig.h"
#import "DJSCTFrameParser.h"
#import "DJSShowTranslateView.h"

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
        self.imageCardLabel.tag = 200;
        [self addSubview:self.imageCardLabel];
        //[self initUI];
    }
    return self;
}

- (void)initUI
{
#pragma mark attention 这里坐标被修改
    DJSDisplayerView * displayView = [[DJSDisplayerView alloc] init];
//    DJSDisplayerView * displayView = [[DJSDisplayerView alloc] initWithFrame:CGRectMake(10, 100, self.bounds.size.width - 20, 0)];
    displayView.backgroundColor = [UIColor clearColor];
    
    //配备文本属性信息
    DJSCTFrameParserConfig * config = [[DJSCTFrameParserConfig alloc] init];
    config.width = displayView.bounds.size.width;
    config.textColor = [UIColor blackColor];
    
    //得到文本数据
    displayView.data = [DJSCTFrameParser parseTemplateWhithoutFileButConfig:config];
    [self addSubview:displayView];
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(100);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(300);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@150);
        make.width.equalTo(self.mas_width);
//        make.edges.equalTo(self);
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
#pragma mark attention   在这里移除那个UILabel 在返回时再用到那个label
    
    oldFrame = pOldframe;
    //当前视图
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundView.backgroundColor = [UIColor darkGrayColor];
    backGroundView.alpha = 0.0f;
    
    //将所有展示的imageView重新绘制到背景视图中
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:oldFrame];
#pragma mark Request 原因找到了 是imageView的问题 应该加一个手势在imageView上 然后再这个手势里面移除视图
    imageView.image = image;
    imageView.tag = 1024;
    [backGroundView addSubview:imageView];
    [window addSubview:backGroundView];
#pragma mark Request: 添加手势：放大后的图片单机则可返回原状 还需添加一个手势 或者：加一个导航栏 用push与pop???
//    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTranslateView:)];
    [imageView addGestureRecognizer:tapGestureRecognizer];
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
//        [cancelButton addTarget:self action:@selector(cancelImageView:) forControlEvents:UIControlEventTouchUpInside];
        [backGroundView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backGroundView.mas_top).offset(15);
            make.left.mas_equalTo(backGroundView.mas_right).offset(-40);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        DJSDisplayerView * displayView = [[DJSDisplayerView alloc] initWithFrame:CGRectMake(0, imageView.bounds.size.height/2, imageView.bounds.size.width, imageView.bounds.size.height/2)];
        imageView.userInteractionEnabled = YES;
        displayView.userInteractionEnabled = YES;
        displayView.tag = 728;
        displayView.backgroundColor = [UIColor clearColor];
        
        //配备文本属性信息
        DJSCTFrameParserConfig * config = [[DJSCTFrameParserConfig alloc] init];
        config.width = displayView.bounds.size.width;
        config.textColor = [UIColor blackColor];
//
//        //得到文本数据
        displayView.data = [DJSCTFrameParser parseTemplateWhithoutFileButConfig:config];
//        [imageView addSubview:displayView];
        
        UILabel * imageCardLabel = [[UILabel alloc] init];
        imageCardLabel.numberOfLines = 0;
        imageCardLabel.textAlignment = NSTextAlignmentCenter;
        imageCardLabel.font = [UIFont systemFontOfSize:15];
//        imageCardLabel.text = @"Absence to love is what wind is to fire. It extinguishes the small; it inflames the great. (Roger de Bussy-Rabutin, French writer)";
        
//        [imageView addSubview:imageCardLabel];
//        [imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(imageView);
//        }];
#pragma mark:从背景视图移除手势
//        [backGroundView removeGestureRecognizer:tapGestureRecognizer];
        [imageView addSubview:displayView];
        
    }];
}

+ (void)hideTranslateView:(UIGestureRecognizer *)tap
{
    UIView * superView = tap.view;
    UIView * translateView = [superView viewWithTag:100];
    [translateView removeFromSuperview];
}

//每个单词的label 双击查看手势
- (void)buildGestureWithLabelText:(NSString *)word forUIImageView:(UIImageView *)imageView
{
    UILabel * textLabel = [[UILabel alloc] init];
    //算出该单词的宽度
    float contentSize = [word boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
    textLabel.text = word;
    [imageView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentSize+10);
#pragma mark - Request: 单词的位置怎么搞???  看一下弹幕的源码 确定他是屏幕上显示的每个弹幕都是一个独一无二的label 不存在占用内存问题
    }];
}

+ (void)cancelImageView:(UIButton *)cancelButton
{
    UIView * backGroundView = cancelButton.superview;
    UIImageView * imageView = [cancelButton.superview viewWithTag:1024];
    UIView * view = [cancelButton.superview viewWithTag:728];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        //[imageView setFrame:oldFrame];
        [backGroundView setAlpha:0];
    } completion:^(BOOL finished) {
        [imageView setFrame:oldFrame];
        [view setFrame:oldFrame];
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
    UIView * view = [tap.view viewWithTag:728];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        //[imageView setFrame:oldFrame];
        [backGroundView setAlpha:0];
    } completion:^(BOOL finished) {
        [imageView setFrame:oldFrame];
        [view setFrame:oldFrame];
        //完成后的操作 把背景视图删除
        [backGroundView removeFromSuperview];
    }];
}



#pragma mark attention 现在的问题：有一层UIlabel覆盖在整个屏幕上 诶 有个办法  可以让这个label的位置设置始终显示那么一点啊！！！ 或者在点击放大图片后清除掉这个label 然后在点击❌号后恢复这个label
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ( [self viewWithTag:100] ){
        UIView * translateView = [self viewWithTag:100];
        UIView * labelView = [self viewWithTag:200];
        [translateView removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
