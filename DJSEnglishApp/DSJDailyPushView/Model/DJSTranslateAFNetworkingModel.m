//
//  DJSTranslateAFNetworkingModel.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSTranslateAFNetworkingModel.h"
#import "NSString+NSString_MD5.h"
#import <AFNetworking.h>
@implementation DJSTranslateAFNetworkingModel

- (void)getTranslateNetworkingWithString:(NSString *)input
{
    NSString * appId = @"5d4b4002ec7509c9";
    NSString * key = @"vt3pIADtrmx0PH4SX88fnz2nPudduNTj";
    NSInteger length = input.length;
    NSString * salt = @"2";
    NSString * from = @"EN";
    NSString * to = @"zh-CHS";
    NSString * string = [NSString stringWithFormat:@"%@%@%@%@",appId,input,salt,key];
    NSString * sign = [NSString md5:string];
    NSString * urlString = [NSString stringWithFormat:@"https://openapi.youdao.com/api?q=%@&from=%@&to=%@&appKey=%@&salt=%@&sign=%@",input,from,to,appId,salt,sign];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    //get请求
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //2.封装参数
    NSDictionary *dict = @{
                           @"username":@"Lion",
                           @"pwd":@"1314",
                           @"type":@"JSON"
                           };
    NSArray * returnArray = [[NSArray alloc] init];
    //urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * resArray = [[responseObject objectForKey:@"basic"] objectForKey:@"explains"];
        //运用块传值！！！
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

@end
