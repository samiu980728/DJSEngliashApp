//
//  DJSShowTranslateView.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/14.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSTranslateAFNetworkingManager.h"

@interface DJSShowTranslateView : UIView

@property (nonatomic, strong) UILabel * translateLabel;

- (void)showTranslateMessageWithString:(NSString *)inputString;

@property (nonatomic, strong) UILabel * englishNameLabel;

@property (nonatomic, strong) UILabel * meanLabel;

@property (nonatomic, strong) UILabel * phoneticSymbolLabel;

@property (nonatomic, strong) UILabel * adjMeanLabel;

@property (nonatomic, assign) CGFloat phoneticReplytoSize;

@property (nonatomic, assign) CGFloat nameLabelReplytoSize;

@property (nonatomic, assign) CGFloat nMeanLabelReplytoSize;

@property (nonatomic, assign) CGFloat adjMeanLabelReplytoSize;

@property (nonatomic, assign) CGFloat nLabelFloat;

@property (nonatomic, assign) CGFloat adjLabelFloat;

@property (nonatomic, strong) DJSTranslateAFNetworkingModel * translateModel;

@property (nonatomic,assign) BOOL ifFetchMessageSucceed;
@end

