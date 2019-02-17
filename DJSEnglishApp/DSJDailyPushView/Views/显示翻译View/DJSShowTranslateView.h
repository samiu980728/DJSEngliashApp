//
//  DJSShowTranslateView.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/14.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSShowTranslateView : UIView

@property (nonatomic, strong) UILabel * translateLabel;

- (void)showTranslateMessageWithString:(NSString *)inputString;

@property (nonatomic, strong) UILabel * englishNameLabel;

@property (nonatomic, strong) UILabel * meanLabel;

@property (nonatomic, strong) UILabel * phoneticSymbolLabel;

@property (nonatomic, assign) CGFloat nameLabelReplytoSize;



@end

