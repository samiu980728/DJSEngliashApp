//
//  DJSCTFrameParserConfig.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCTFrameParserConfig.h"

@implementation DJSCTFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor blackColor];
    }
    return self;
}

@end
