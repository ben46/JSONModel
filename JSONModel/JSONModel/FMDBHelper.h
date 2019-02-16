//
//  FMDBHelper.h
//  JSONModelDemo_iOS
//
//  Created by zhou on 14-5-1.
//  Copyright (c) 2014年 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "JMDefine.h"


@interface FMDBHelper : FMDatabase

+ (instancetype)sharedInstance;

/**
 *  删除数据库文件
 */
+ (void)deleteDataBaseFile;

- (FMResultSet *)JM_executeQuery:(NSString*)sql;

- (void)JM_executeQuery:(NSString*)sql block:(FMDBCompletionBlock)block;
- (void)JM_executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments completion:(FMDBCompletionBlock)block;

- (void)JM_executeUpdate:(NSString *)sql;
- (void)JM_executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params;
- (void)JM_executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params completion:(FMDBUpdateCompletionBlock)block;

- (BOOL)JM_executeStatements:(NSString *)sql;
- (BOOL)JM_executeStatements:(NSString *)sql block:(FMDBExecuteStatementsCallbackBlock)block;

@end
