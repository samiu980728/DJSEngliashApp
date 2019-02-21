//
//  DJSShowTranslateView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/14.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSShowTranslateView.h"
#import <Masonry.h>
@implementation DJSShowTranslateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _phoneticReplytoSize = 0;
        _nameLabelReplytoSize = 0;
        _nMeanLabelReplytoSize = 0;
        _adjMeanLabelReplytoSize = 0;
        _nLabelFloat = 0;
        _adjLabelFloat = 0;
        self.ifFetchMessageSucceed = NO;
        self.translateLabel = [[UILabel alloc] init];
        self.translateLabel.backgroundColor = [UIColor yellowColor];
        //[self addSubview:self.translateLabel];
        self.englishNameLabel = [[UILabel alloc] init];
//        self.englishNameLabel.adjustsFontSizeToFitWidth = true;
        [self addSubview:self.englishNameLabel];
        self.phoneticSymbolLabel = [[UILabel alloc] init];
        [self addSubview:self.phoneticSymbolLabel];
        self.backgroundColor = [UIColor whiteColor];
        
        self.meanLabel = [[UILabel alloc] init];
        [self addSubview:self.meanLabel];
        self.adjMeanLabel = [[UILabel alloc] init];
        [self addSubview:self.adjMeanLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.translateLabel.numberOfLines = 0;
    //self.translateLabel.backgroundColor = [UIColor clearColor];
//    [self.translateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    self.englishNameLabel.numberOfLines = 0;
    self.englishNameLabel.font = [UIFont systemFontOfSize:25];
//    self.englishNameLabel.adjustsFontSizeToFitWidth = true;
    [self.englishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(_nameLabelReplytoSize);
    }];
    self.englishNameLabel.adjustsFontSizeToFitWidth = true;
    NSLog(@"原来的_nameLabelReplytoSize = %f",_nameLabelReplytoSize);
    
    self.phoneticSymbolLabel.numberOfLines = 0;
    self.phoneticSymbolLabel.font = [UIFont systemFontOfSize:20];
    [self.phoneticSymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.englishNameLabel.mas_right).offset(20);
        make.top.mas_equalTo(self.englishNameLabel.mas_top).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    self.meanLabel.numberOfLines = 0;
    self.meanLabel.font = [UIFont systemFontOfSize:20];
    [self.meanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.englishNameLabel.mas_left);
        make.top.mas_equalTo(self.englishNameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(self.nMeanLabelReplytoSize+10);
    }];
    
    self.adjMeanLabel.numberOfLines = 0;
    self.adjMeanLabel.font = [UIFont systemFontOfSize:20];
    CGFloat adjMeanHeight = ceil(self.adjMeanLabelReplytoSize) + 1;
    [self.adjMeanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.englishNameLabel.mas_left);
        make.top.equalTo(self.meanLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(adjMeanHeight);
    }];
    NSLog(@"self.englishNameLabel.font = %@",self.englishNameLabel.font);
}

- (void)showTranslateMessageWithString:(NSString *)inputString
{
#pragma mark Question 不知道在这里修改宽度后 在layoutSubviews 里的Masonry会不会重新设置宽度
    [self caculateLabelHeightWithNameString:inputString];
    DJSTranslateAFNetworkingManager * translateManager = [DJSTranslateAFNetworkingManager sharedManager];
    [translateManager fetchDataWithTranslateAFNetworkingModelAndString:inputString Succeed:^(DJSTranslateAFNetworkingModel *translateModel) {
    if ([translateModel.translateArray isKindOfClass:[NSArray class]] && translateModel.translateArray.count > 0) {
        _ifFetchMessageSucceed = YES;
        _translateModel = translateModel;
        NSArray * translateMessageArray = translateModel.translateArray;
        NSString * translteString = translateMessageArray[0];
        NSString * adjTranslateString = [[NSString alloc] init];
        if (translateMessageArray.count >= 2){
        adjTranslateString = translateMessageArray[1];
        }
        NSLog(@"translteString = %@",translteString);
        NSMutableString * string = [[NSMutableString alloc] init];
        for (int i = 0; i < translateMessageArray.count; i++) {
            [string appendString:translateMessageArray[i]];
        }
        self.englishNameLabel.text = inputString;
        self.phoneticSymbolLabel.text = translateModel.phoneticString;
        
        [self caculateLabelHeightWithPhoneticString:translateModel.phoneticString];
        [self caculateLabelHeightWithTranslateString:translteString andHeightSize:_nLabelFloat];
        [self caculateLabelHeightWithTranslateString:adjTranslateString andHeightSize:_adjLabelFloat];
        NSLog(@"_nMeanLabelReplytoSize = %f _adjMeanLabelReplytoSize = %f",_nMeanLabelReplytoSize,_adjMeanLabelReplytoSize);
        }
    } error:^(NSError *error) {
        NSLog(@"error --- %@",error);
    }];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        if (self.ifFetchMessageSucceed) {
        NSLog(@"终于最后的---_nLabelFloat = %f _adjLabelFloat = %f",_nLabelFloat,_adjLabelFloat);
        _nMeanLabelReplytoSize = _nLabelFloat;
        _adjMeanLabelReplytoSize = _adjLabelFloat;
        NSArray * translateMessageArray = _translateModel.translateArray;
        NSString * translteString = translateMessageArray[0];
        NSString * adjTranslateString = translateMessageArray[1];
        NSLog(@"translteString---- = %@",translteString);
            
//            self.englishNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.englishNameLabel.text = inputString;
            self.phoneticSymbolLabel.text = _translateModel.phoneticString;
        self.meanLabel.text = translteString;
        self.adjMeanLabel.text = adjTranslateString;
#pragma mark Request 宽度的计算还是有问题  其他还好
        self.englishNameLabel.numberOfLines = 0;
        self.englishNameLabel.font = [UIFont systemFontOfSize:25];
            //self.englishNameLabel.adjustsFontSizeToFitWidth = true;
            NSLog(@"第二次布局时_nameLabelReplytoSize = %f _phoneticReplytoSize = %f",_nameLabelReplytoSize,_phoneticReplytoSize);
            CGFloat width = (ceil)(_nameLabelReplytoSize) + 1;
            NSLog(@"111width = %f",width);
            self.englishNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.englishNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(_nameLabelReplytoSize);
            make.width.mas_equalTo(width);
        }];
           // self.englishNameLabel.adjustsFontSizeToFitWidth = true;
            dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(3.0 * NSEC_PER_SEC));
            dispatch_after(time1, dispatch_get_main_queue(), ^{
                NSLog(@"self.englishNameLabel.mas_width = %f",self.englishNameLabel.frame.size.width);
            });
            
        self.phoneticSymbolLabel.numberOfLines = 0;
        self.phoneticSymbolLabel.font = [UIFont systemFontOfSize:20];
            CGFloat phoneticWidth = ceil(self.phoneticReplytoSize) + 1;
        [self.phoneticSymbolLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.englishNameLabel.mas_right).offset(20);
            make.top.mas_equalTo(self.englishNameLabel.mas_top).offset(5);
            make.height.mas_equalTo(20);
//            make.width.mas_equalTo(_phoneticReplytoSize);
            make.width.mas_equalTo(phoneticWidth);
        }];
        
#pragma mark Request 动态计算宽度！！！ 不用吧
        self.meanLabel.numberOfLines = 0;
        self.meanLabel.font = [UIFont systemFontOfSize:20];
            CGFloat meadHeight = ceil(self.nMeanLabelReplytoSize) + 1;
        [self.meanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.englishNameLabel.mas_left);
            make.top.mas_equalTo(self.englishNameLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(self.nMeanLabelReplytoSize+10);
            make.height.mas_equalTo(meadHeight);
        }];
        
        self.adjMeanLabel.numberOfLines = 0;
//            self.adjMeanLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        self.adjMeanLabel.adjustsFontSizeToFitWidth = true;
        self.adjMeanLabel.font = [UIFont systemFontOfSize:20];
            CGFloat adjMeanHeight = ceil(self.adjMeanLabelReplytoSize) + 1;
            NSLog(@"adjMeanHeight = %f",adjMeanHeight);
            NSLog(@"self.adjMeanLabel.font = %@",self.adjMeanLabel.font);
        [self.adjMeanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.englishNameLabel.mas_left);
            make.top.mas_equalTo(self.meanLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(self.adjMeanLabelReplytoSize+20);
            make.height.mas_equalTo(adjMeanHeight);
        }];
        
        }
    });
    
    
}

- (void)caculateLabelHeightWithTranslateString:(NSString *)translateString andHeightSize:(CGFloat)heightSizeFloat
{
    heightSizeFloat = [translateString boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size.height;
    
    _nLabelFloat = [translateString boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size.height;
    
    _adjLabelFloat = [translateString boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size.height;
    NSLog(@"这里的_nLabelFloat = %f _adjLabelFloat = %f",_nLabelFloat,_adjLabelFloat);
}

- (void)caculateLabelHeightWithNameString:(NSString *)nameString
{
    self.nameLabelReplytoSize = [nameString boundingRectWithSize:CGSizeMake(326, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size.width;
    NSLog(@"self.nameLabelReplytoSize = %f",_nameLabelReplytoSize);
}

- (void)caculateLabelHeightWithPhoneticString:(NSString *)phoneticString
{
    _phoneticReplytoSize = [phoneticString boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size.width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
