//
//  DJSCoreTextLinkData.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCoreTextLinkData.h"

@implementation DJSCoreTextLinkData

+ (DJSCoreTextLinkData *)touchLinkView:(UIView *)view atPoint:(CGPoint)point data:(DJSCoreTextData *)data
{
    //得到文本的CTFrameRef
    CTFrameRef ctFrame = data.ctFrame;
    //得到ctFrame所有行消息
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    if (lines == nil) {
        return nil;
    }
    
    //得到行的具体数量
    CFIndex linesCount = CFArrayGetCount(lines);
    
    DJSCoreTextLinkData * linkData = nil;
    
    //存储每一行的CGPoint
    CGPoint linesOrigins[linesCount];
    
    //    range： 用来指定我们想获取的line的origion(原点)的个数如果是0的话那么就会返回frame下全部的line
    //    linesOrigins:存放所有原点的数组
    //    ctFrame:文本的CTFrameRef
    ///获取所有CTLineRef的基础原点，传入CTFrame，CFRange，和一个CGPoint的结构体数组指针，该函数会把每一个CTLine的origin坐标写到数组里。
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), linesOrigins);
    
    //因为CoreText 和UIKit坐标系不同 所以需要做一个对应的坐标转换
    ///创建一个平移的变化 假设是一个视图，那么它的起始位置 x 会加上tx , y 会加上 ty
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1, -1);
    
    //遍历所有line
    for (int i = 0; i < linesCount; i++) {
        //得到每一行 line 的坐标
        CGPoint linePoint = linesOrigins[i];
        //得到数组中第i个CTlineRef
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        //获取当前行的rect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        //将CoreText坐标转化为UIKit坐标
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        //判断点是否在Rect当中
        if (CGRectContainsPoint(rect, point)) {
            //获取点在line行中的位置 然后判断属于这一行中的哪个CTRun
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            ///判断属于该行的哪个CTRun
            //获取point点中字符在line行中的位置（在属性文字中是第几个字）
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            NSLog(@"idx 第几个字呢？ = %li",idx);
            
            ///判断此字符是否在那个蓝色链接范围中
            //判断此字符是否在链接属性文字当中
            //前面几行有： CoreTextLinkData *linkdata = nil;
            //linkAtIndex:这个函数就是通过idx根据位置来判断第idx个字符是否在data.linkArray 这个之前就设置好的存放链接的数组中
            //意思就是看你点击的这个字符是否是之前设置好的字符链接中的字符中的一个
            linkData = [self linkAtIndex:idx linkArray:data.linkArray];
            NSString * urlStr = @"GaoYiJiaAbsence to love is what wind is to fire. It extinguishes the small; it inflames the great. (Roger de Bussy-Rabutin, French writer";
#pragma mark  得到idx 遍历urlStr 得到编号为idx之前的一个空格和之后的一个空格 首先得把string放到数组中去
            NSRange range;
            NSMutableArray * urlMutArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < urlStr.length; i += range.length) {
                unichar chara = [urlStr characterAtIndex:i];
                range = [urlStr rangeOfComposedCharacterSequenceAtIndex:i];
                NSString * subStr = [urlStr substringWithRange:range];
                //NSLog(@"subStr = %@ NSStringFromRange(range) = %@",subStr,NSStringFromRange(range));
                [urlMutArray addObject:subStr];
            }
            NSLog(@"urlMutArray = %@",urlMutArray);
            NSString * getString = [urlMutArray objectAtIndex:idx];
            if ([getString isEqualToString:@" "]) {
                linkData.urlString = @"";
            } else {
                NSString * blackSpaceStr = [[NSString alloc] init];
                NSString * blackSpaceRightStr = [[NSString alloc] init];
                NSInteger blackSpaceLeftInteger = 0;
                NSInteger blackSpaceRightInteger = 0;
                NSInteger ifBlackSpaceInteger = 0;
                for (int i = (int)idx-1; i > 0; i--) {
                NSString * idxStr = [urlMutArray objectAtIndex:i];
                if ([idxStr isEqualToString:@" "]) {
                    blackSpaceStr = [urlMutArray objectAtIndex:i+1];
                    blackSpaceLeftInteger = i;
                    ifBlackSpaceInteger = 1;
                    break;
                }
            }
                if (ifBlackSpaceInteger == 0) {
                    blackSpaceStr = [urlMutArray objectAtIndex:0];
                    blackSpaceLeftInteger = 0;
                }
                
                NSInteger ifBlackSpaceRightInteger = 0;
                for (int i = (int)idx-1; i < urlMutArray.count; i++) {
                    NSString * idxStr = [urlMutArray objectAtIndex:i];
                    if ([idxStr isEqualToString:@" "]) {
                        blackSpaceRightStr = [urlMutArray objectAtIndex:i-1];
                        blackSpaceRightInteger = i;
                        ifBlackSpaceRightInteger = 1;
                        break;
                    }
                }
                if (ifBlackSpaceRightInteger == 0) {
                    blackSpaceRightStr = urlMutArray[urlMutArray.count-1];
                    blackSpaceRightInteger = urlMutArray.count-1;
                }
                
#pragma mark  好了 现在实现完毕得到点击处的具体单词功能了 下一步就是调用接口  
                NSLog(@"blackSpaceStr = %@ blackSpaceRightStr = %@\n blackSpaceLeftInteger = %li blackSpaceRightInteger = %li",blackSpaceStr,blackSpaceRightStr,blackSpaceLeftInteger,blackSpaceRightInteger);
            NSString * realStr = [urlStr substringFromIndex:idx];
            linkData.urlString = realStr;
            }
            break;
        }
    }
    return linkData;
    
}

+ (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    //配置line行的位置信息
    CGFloat ascent = 0;
    CGFloat descent = 0;
    CGFloat leading = 0;
    //在获取line行宽度信息的同时得到其他信息
    ///获取CTLine的上行高度，下行高度，行距
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}

#pragma mark attention 在这里加一个参数 需要用这个数组存储显示界面的所有单词 依次序排好 这样就可以通过CFIdex i 来或得到这个数组中的某个单元
+ (DJSCoreTextLinkData *)linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray
{
    NSLog(@"linkArray = %@",linkArray);
    DJSCoreTextLinkData * linkData = nil;
    for (DJSCoreTextLinkData * data in linkArray) {
        //data.range: 文字在属性文字中的范围
        NSRange range = data.range;
        //NSLocationInRange: 判断所给下标i是否在data.range内 data.range是NSRange类型
        if (NSLocationInRange(i, data.range)) {
            linkData = data;
            break;
        }
    }
    return linkData;
}

@end
