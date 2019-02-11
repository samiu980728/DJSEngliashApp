//
//  DJSCTFrameParser.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/10.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCTFrameParser.h"
#import <CoreText/CoreText.h>
#import "DJSCoreTextLinkData.h"
@implementation DJSCTFrameParser
#pragma mark attention
+ (DJSCoreTextData *)parseTemplateWhithoutFileButConfig:(DJSCTFrameParserConfig *)config
{
    NSMutableArray * linkArray = [NSMutableArray array];
    NSAttributedString * content = [self loadContentFromWithoutFileButconfig:config linkArray:linkArray];
    DJSCoreTextData * data = [self parseAttributedContent:content config:config];
    data.linkArray = linkArray;
    return data;
}

+ (NSAttributedString *)loadContentFromWithoutFileButconfig:(DJSCTFrameParserConfig *)config linkArray:(NSMutableArray *)linkArray
{
    NSMutableAttributedString *attStringM = [[NSMutableAttributedString alloc] init];
    
    //用一个数组存储所有文字信息
    NSUInteger startPos = attStringM.length;
    NSLog(@"startPos = %li",startPos);
    NSAttributedString * attString0 = [[NSAttributedString alloc] initWithString:@"GaoYiJia"];
    [attStringM appendAttributedString:attString0];
    startPos = attStringM.length;
    NSAttributedString * attString = [self parseAttributedContentWithoutNSDictionaryButConfig:config];
    [attStringM appendAttributedString:attString];
    NSRange linkRange = NSMakeRange(startPos, attString.length);
    DJSCoreTextLinkData * linkdata = [[DJSCoreTextLinkData alloc] init];
    linkdata.range = linkRange;
    //这作用就是为了显示到弹窗上 没啥其他作用
    //linkdata.urlString = @"https://github.com/samiu980728/CoreText-/edit/master/README.mdahahhahah";
    [linkArray addObject:linkdata];
    
#pragma mark Answer 我大概懂她的思路了 因为上面还需要传一个rang参数——范围 所以就需要有rang的起点和长度 那么起点的计算就至关重要
    
#pragma mark attention 还可以通过attStringM 添加其他样式的富文本 再看一下这个函数应该在哪里调用
    return attStringM;
}


+ (NSAttributedString *)parseAttributedContentWithoutNSDictionaryButConfig:(DJSCTFrameParserConfig *)config
{
    NSMutableDictionary * attributes = [self attributesWithConfig:config];
    
    //设置字体大小
    //    CGFloat fontSize = [dict[@"size"] floatValue];
    //    if (fontSize > 0) {
    //        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    //        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    //        CFRelease(fontRef);
    //    }
    //配置文字
    //    NSString *content = dict[@"content"];
    //    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    NSAttributedString * attString1 = [[NSAttributedString alloc] initWithString:@"https://github.com/samiu980728/CoreText-/edit/master/README.md 12 212121212565656565656565"];
    
    return attString1;
}

#pragma mark attention 这个函数加入与否只是与字体大小还有字形相关 不影响实际使用
+ (NSMutableDictionary *)attributesWithConfig:(DJSCTFrameParserConfig *)config {
    //配置字体信息
    CGFloat fontSize = config.fontSize;
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    //配置间距
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {
            kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace
        }
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    //配置颜色
    UIColor *textColor = config.textColor;
    //将配置信息加入字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)ctFont;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    //释放变量
    CFRelease(theParagraphRef);
    CFRelease(ctFont);
    
    return dict;
}


/**
 *  根据属性文字对象和配置信息对象生成CoreTextData对象
 *
 *  @param content 属性文字对象
 *  @param config  配置信息对象
 *
 *  @return CoreTextData对象
 */
#pragma mark attention  根据这个函数来配置文本+图片对象   没有这个函数 界面上什么都没有
+ (DJSCoreTextData *)parseAttributedContent:(NSAttributedString *)content
                                  config:(DJSCTFrameParserConfig *)config
{
    // 创建CTFrameSetterRef实例
    CTFramesetterRef ctFrameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    //获取要绘制的区域信息
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetterRef, CFRangeMake(0, 0), NULL, restrictSize, NULL);
    CGFloat textHeight = coreTextSize.height;
    //配置ctframeRef信息
    CTFrameRef ctFrame = [self createFrameWithFramesetting:ctFrameSetterRef config:config height:textHeight];
    //配置coreTextData数据
#pragma mark attention  这个也很重要哦 根据 CoreTextData 这个类中计算的高度和ctFrame来绘制
    DJSCoreTextData *data = [[DJSCoreTextData alloc] init];
    data.ctFrame = ctFrame;
    data.height = textHeight;
    
    
    //释放内存
    CFRelease(ctFrame);
    CFRelease(ctFrameSetterRef);
    return data;
}

/**
 *  根据CTFramesetterRef、配置信息对象和高度生成对应的CTFrameRef
 *
 *  @param frameSetter CTFramesetterRef
 *  @param config      配置信息对象
 *  @param height      CTFrame高度
 *
 *  @return CTFrameRef
 */
#pragma mark attention 这个也很重要
+ (CTFrameRef)createFrameWithFramesetting:(CTFramesetterRef)frameSetter
                                   config:(DJSCTFrameParserConfig *)config
                                   height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef ctframeRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return ctframeRef;
}

/**
 *  根据配置信息对象和文字生成对应的CoreTextData对象
 *
 *  @param content 文本内容
 *  @param config  文本配置信息
 *
 *  @return CoreText对象
 */
+ (DJSCoreTextData *)parseContent:(NSString *)content config:(DJSCTFrameParserConfig *)config {
    //创建文字并配置属性
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    return [self parseAttributedContent:attString config:config];
}



@end
