//
//  DJSTranslateAFNetworkingManager.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSTranslateAFNetworkingManager.h"
#import <AFNetworking.h>
#import "NSString+NSString_MD5.h"
@implementation DJSTranslateAFNetworkingManager

static DJSTranslateAFNetworkingManager * manager = nil;

+ (id)sharedManager
{
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchDataWithTranslateAFNetworkingModelAndString:(NSString *)input
                                                  Succeed:(DJSGetTranslateModelHandle)succeedBlock
                                                    error:(ErrorHandle)errorBlock;
{
    NSString * appId = @"5d4b4002ec7509c9";
    NSString * key = @"vt3pIADtrmx0PH4SX88fnz2nPudduNTj";
    NSString * salt = @"2";
    NSString * from = @"EN";
    NSString * to = @"zh-CHS";
    NSString * string = [NSString stringWithFormat:@"%@%@%@%@",appId,input,salt,key];
    NSString * sign = [NSString md5:string];
    NSString * urlString = [NSString stringWithFormat:@"https://openapi.youdao.com/api?q=%@&from=%@&to=%@&appKey=%@&salt=%@&sign=%@",input,from,to,appId,salt,sign];
    //get请求
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //2.封装参数
    NSDictionary *dict = @{
                           @"username":@"Lion",
                           @"pwd":@"1314",
                           @"type":@"JSON"
                           };
    [manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * resArray = [[responseObject objectForKey:@"basic"] objectForKey:@"explains"];
        NSString * phoneticString = [[responseObject objectForKey:@"basic"] objectForKey:@"us-phonetic"];
        //运用块传值！！！
        DJSTranslateAFNetworkingModel * translateModel = [[DJSTranslateAFNetworkingModel alloc] init];
        translateModel.translateArray = [[NSArray alloc] init];
        translateModel.translateArray = resArray;
        translateModel.phoneticString = phoneticString;
        succeedBlock(translateModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            errorBlock(error);
        }
        NSLog(@"error = %@",error);
    }];
}

@end
