//
//  DJSSetSQLiteManager.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/2/23.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSSetSQLiteManager.h"

@implementation DJSSetSQLiteManager

static DJSSetSQLiteManager * manager = nil;
//static FMDatabase * articleSqlDataBase;
+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
//        articleSqlDataBase = [[FMDatabase alloc] init];
    });
    return manager;
}

- (void)createFMDBDataSourceWithSQLName:(NSString *)sqlName
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:sqlName];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if (!_articleSqlDataBase) {
        _articleSqlDataBase = db;
    }
    [db open];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'DJSArticleSQLite' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , 'articleText' text)";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"文章错啦");
        } else {
            NSLog(@"文章对啦");
        }
        [db close];
    } else {
        NSLog(@"打不开呀");
    }
}

- (void)insertArticleWith:(NSString *)articleStr ToDataBase:(FMDatabase *)dataBase andName:(NSString *)tableNameStr
{
    [dataBase open];
    NSString * sql = [NSString stringWithFormat:@"insert into %@ (articleText) values(?) ",tableNameStr];
    BOOL insertArticleSQLDataBaseResult = NO;
    insertArticleSQLDataBaseResult = [dataBase executeUpdate:sql, articleStr];
    if (!insertArticleSQLDataBaseResult) {
        NSLog(@"传值失败");
    } else {
        NSLog(@"传值成功");
    }
    [dataBase close];
}

- (void)openArticleDataBaseWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr CaughtInatricleMutArray :(NSMutableArray *)articleMutArray
{
    if ([dataBase open]) {
        FMResultSet * getRes = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableNameStr]];
        while ([getRes next]) {
            NSString * articleStr = [NSString stringWithFormat:@"%@",[getRes stringForColumnIndex:1]];
            [articleMutArray addObject:articleStr];
        }
    }
    [dataBase close];
}

- (void)deleteArticleSQLDataBaseWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr
{
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableNameStr];
        BOOL res = [dataBase executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else{
            NSLog(@"succ to deleta db data");
        }
        [dataBase close];
    }
}

@end
