//
//  DJSCoreTextLinkData.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJSCoreTextData.h"
#import <UIKit/UIKit.h>
@interface DJSCoreTextLinkData : NSObject

///点击生成的每个url链接的地址
@property (nonatomic, strong) NSString * urlString;

///文字在属性文字中的范围
@property (nonatomic, assign) NSRange range;

/**
 *  若点击位置有链接 返回链接对象 否则返回nil
 *
 *  @param view 点击的视图
 *  @param point 点击的位置
 *  @param data 存放富文本的数据
 *  @return 返回链接对象
 */
+ (DJSCoreTextLinkData *)touchLinkView:(UIView *)view atPoint:(CGPoint)point data:(DJSCoreTextData *)data;


@end
