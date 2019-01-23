//
//  DJSEnglishCardImageView.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSEnglishCardImageView.h"
#import <Masonry.h>
@implementation DJSEnglishCardImageView

//imageView 的 action: 就是一个方法 ：@seletor(clicked:) 这个方法里面具体的内容就是点击后该imageView进行高亮，并将其位置从左侧或者右侧切换到中间并且在移动的过程中均匀变大
//问题：应该怎么让其他的imageView联动切换？
//可以给所有imageView中的内容分别存储到数组的每个单元中向右移动时则显示在主界面上的(两个侧面小imageView与一个主iamgeView)共三个imageView的编号分别+1或-1
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpeg"]];
        self.imageCardLabel = [[UILabel alloc] init];
        [self addSubview:self.imageCardLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.imageCardLabel.font = [UIFont systemFontOfSize:15];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [(NSObject *)self.target performSelectorInBackground:self.action withObject:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
