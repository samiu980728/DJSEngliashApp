//
//  DJSCTFrameParserConfig.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DJSCTFrameParserConfig : NSObject

/** 文本宽度 */
@property (nonatomic, assign) CGFloat width;

/** 字体大小 */
@property (nonatomic, assign) CGFloat fontSize;

/** 字体行间距 */
@property (nonatomic, assign) CGFloat lineSpace;

/** 字体颜色 */
@property (nonatomic, strong) UIColor *textColor;

@end
