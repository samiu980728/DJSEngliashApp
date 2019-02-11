//
//  DJSCoreTextData.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/9.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCoreTextData.h"

@implementation DJSCoreTextData

- (void)setCtFrame:(CTFrameRef)ctFrame
{
    if (_ctFrame != nil && _ctFrame != ctFrame) {
        NSLog(@"_ctFrame = %@",_ctFrame);
        CFRelease(_ctFrame);
    }
    //错误原因 这里用过之后已经释放了一次 成为了一个僵尸对象
    CFRetain(ctFrame);
    _ctFrame = ctFrame;
}

- (void)dealloc
{
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

@end
