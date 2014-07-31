//
//  FMDBHelper.h
//  JSONModelDemo_iOS
//
//  Created by zhou on 14-5-1.
//  Copyright (c) 2014年 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

typedef void(^FMDBCompletionBlock)(NSError *err, FMResultSet* rsl);

@interface FMDBHelper : FMDatabase

+ (instancetype)sharedInstance;

/**
 *  删除数据库文件
 */
+ (void)deleteDataBaseFile;

- (FMResultSet *)JM_executeQuery:(NSString*)sql;
- (void)JM_executeQuery:(NSString*)sql block:(FMDBCompletionBlock)block;

- (BOOL)JM_executeUpdate:(NSString*)sql;
- (void)JM_executeUpdate:(NSString*)sql block:(FMDBCompletionBlock)block;

- (BOOL)JM_executeStatements:(NSString *)sql;
- (BOOL)JM_executeStatements:(NSString *)sql block:(FMDBExecuteStatementsCallbackBlock)block;

@end
