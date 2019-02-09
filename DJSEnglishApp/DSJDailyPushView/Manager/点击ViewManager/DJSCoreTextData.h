//
//  DJSCoreTextData.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/9.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface DJSCoreTextData : NSObject

/// 文本绘制的区域大小
@property (nonatomic, assign) CTFrameRef ctFrame;

/// 文本绘制的区域高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSMutableArray * imageArray;

///文本中存储链接信息的数组
@property (nonatomic, strong) NSMutableArray * linkArray;

@end
