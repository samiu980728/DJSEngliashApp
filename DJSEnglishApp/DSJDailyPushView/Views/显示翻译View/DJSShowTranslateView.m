//
//  DJSShowTranslateView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/14.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSShowTranslateView.h"
#include "DJSTranslateAFNetworkingManager.h"
#import <Masonry.h>
@implementation DJSShowTranslateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translateLabel = [[UILabel alloc] init];
        self.meanLabel = [[UILabel alloc] init];
        [self addSubview:self.meanLabel];
        self.englishNameLabel = [[UILabel alloc] init];
        [self addSubview:self.englishNameLabel];
        self.phoneticSymbolLabel = [[UILabel alloc] init];
        [self addSubview:self.phoneticSymbolLabel];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.translateLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.translateLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpeg"]];
    self.translateLabel.numberOfLines = 0;
    self.translateLabel.backgroundColor = [UIColor clearColor];
    self.translateLabel.font = [UIFont systemFontOfSize:20];
    [self.translateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.englishNameLabel.numberOfLines = 0;
    [self.englishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.nameLabelReplytoSize);
    }];
    
    self.phoneticSymbolLabel.numberOfLines = 0;
    [self.phoneticSymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.englishNameLabel.mas_right).offset(20);
        make.top.mas_equalTo(self.englishNameLabel.mas_top);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
}

- (void)showTranslateMessageWithString:(NSString *)inputString
{
#pragma mark Question 不知道在这里修改宽度后 在layoutSubviews 里的Masonry会不会重新设置宽度
    [self caculateLabelHeightWithNameString:inputString];
    DJSTranslateAFNetworkingManager * translateManager = [DJSTranslateAFNetworkingManager sharedManager];
    [translateManager fetchDataWithTranslateAFNetworkingModelAndString:inputString Succeed:^(DJSTranslateAFNetworkingModel *translateModel) {
        NSArray * translateMessageArray = translateModel.translateArray;
        NSMutableString * string = [[NSMutableString alloc] init];
        for (int i = 0; i < translateMessageArray.count; i++) {
            [string appendString:translateMessageArray[i]];
        }
        self.englishNameLabel.text = inputString;
        self.phoneticSymbolLabel.text = translateModel.phoneticString;
        //self.translateLabel.text = string;
    } error:^(NSError *error) {
        NSLog(@"error --- %@",error);
    }];
}

- (void)caculateLabelHeightWithNameString:(NSString *)nameString
{
    self.nameLabelReplytoSize = [nameString boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
#pragma mark   宽度的计算有些问题   拿一个比较长的字符再试一次  得到这个宽度数据后 没有进行Masonry重布局？？？
    NSLog(@"self.nameLabelReplytoSize = %f",self.nameLabelReplytoSize);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
