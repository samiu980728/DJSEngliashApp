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
        CFRelease(_ctFrame);
    }
    CFRetain(ctFrame);
    _ctFrame = ctFrame;
}

- (void)dealloc
{
    if (self.ctFrame != nil) {
        CFRelease(self.ctFrame);
        self.ctFrame = nil;
    }
}

@end
