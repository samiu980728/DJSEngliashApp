//
//  DJSSetSQLiteManager.h
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface DJSSetSQLiteManager : NSObject

+ (instancetype)sharedManager;

///创建数据库
- (void)createFMDBDataSourceWithSQLName:(NSString *)sqlName;

@property (nonatomic, strong) FMDatabase * articleSqlDataBase;
@end
