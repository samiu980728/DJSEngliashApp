//
//  DJSEnglishCardImageView.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/1/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSEnglishCardImageView : UIImageView

@property (nonatomic, strong) UIImage * cardImage;

@property (nonatomic, strong) UILabel * textLabel;

@property (nonatomic, strong) UILabel * imageCardLabel;

@property (nonatomic, assign) id target;

@property (nonatomic, assign) SEL action;

@end
