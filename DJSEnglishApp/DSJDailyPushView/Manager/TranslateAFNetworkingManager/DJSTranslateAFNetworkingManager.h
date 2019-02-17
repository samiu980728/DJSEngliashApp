//
//  DJSTranslateAFNetworkingManager.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJSTranslateAFNetworkingModel.h"
typedef void(^DJSGetTranslateModelHandle)(DJSTranslateAFNetworkingModel * translateModel);

typedef void(^ErrorHandle)(NSError * error);

@interface DJSTranslateAFNetworkingManager : NSObject

+ (instancetype)sharedManager;

//导入网络请求
- (void)fetchDataWithTranslateAFNetworkingModelAndString:(NSString *)input
                                                 Succeed:(DJSGetTranslateModelHandle)succeedBlock
                                                 error:(ErrorHandle)errorBlock;
@end
