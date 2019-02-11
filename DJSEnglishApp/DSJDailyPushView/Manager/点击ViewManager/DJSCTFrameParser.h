//
//  DJSCTFrameParser.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DJSCTFrameParserConfig.h"
#import "DJSCoreTextData.h"

@interface DJSCTFrameParser : NSObject

/**
 *  根据字符串和配置信息对象生成CoreTextData对象
 *
 *  @param content 字符串
 *  @param config  配置信息对象
 *
 *  @return CoreTextData对象
 */
+ (DJSCoreTextData *)parseContent:(NSString *)content config:(DJSCTFrameParserConfig *)config;


+ (DJSCoreTextData *)parseTemplateWhithoutFileButConfig:(DJSCTFrameParserConfig *)config ;

+ (NSAttributedString *)loadContentFromWithoutFileButconfig:(DJSCTFrameParserConfig *)config
                                                  linkArray:(NSMutableArray *)linkArray ;

@end
