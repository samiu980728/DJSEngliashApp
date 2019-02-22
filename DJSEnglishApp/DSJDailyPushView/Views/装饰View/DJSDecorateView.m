//
//  DJSDecorateView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/22.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSDecorateView.h"
#import <Masonry.h>

@implementation DJSDecorateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.splitLineView = [[UIView alloc] init];
        [self addSubview:self.splitLineView];
        self.optionImageView = [[UIImageView alloc] init];
        [self addSubview:self.optionImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.splitLineView.backgroundColor = [UIColor darkGrayColor];
    self.splitLineView.alpha = 0.3;
    
    self.optionImageView.image = [UIImage imageNamed:@"10.png"];
    [self.optionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(4);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(19);
    }];
    
    [self.splitLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.optionImageView.mas_bottom).offset(4);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
