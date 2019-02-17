//
//  DJSTranslateAFNetworkingModel.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSTranslateAFNetworkingModel : NSObject

@property (nonatomic, copy) NSArray * translateArray;

@property (nonatomic, copy) NSString * phoneticString;
- (void)getTranslateNetworkingWithString:(NSString *)input;

@end
