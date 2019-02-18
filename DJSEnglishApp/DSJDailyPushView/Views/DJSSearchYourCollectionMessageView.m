//
//  DJSSearchYourCollectionMessageView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/21.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSSearchYourCollectionMessageView.h"

@implementation DJSSearchYourCollectionMessageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchLabel = [[UILabel alloc] init];
        [self addSubview:self.searchLabel];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor yellowColor];
    self.searchLabel.font = [UIFont systemFontOfSize:15];
    self.searchLabel.text = @"所有的结局都已写好，所有的泪水都已启程";
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cancelButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.left.mas_equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
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
