//
//  DJSEnglishCardImageView.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSEnglishCardImageView : UIImageView

@property (nonatomic, strong) UIImage * cardImage;

@property (nonatomic, strong) UILabel * textLabel;

@property (nonatomic, strong) UILabel * imageCardLabel;

@property (nonatomic, assign) id target;

@property (nonatomic, assign) SEL action;

/**
 * 浏览大图
 *
 * @param currentImageView 图片所在的imageView
 */
+ (void)scanBigImageWithImageView:(UIImageView *)currentImageView;

/**
 浏览大图 - 如果图片不是在imageView上可用此方法.
 
 @param image 查看的图片对象
 @param pOldframe 当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值 [currentImageview convertRect:currentImageview.bounds toView:window];
 */
+ (void)scanBigImageWithImage:(UIImage *)image frame:(CGRect)pOldframe;

@end
