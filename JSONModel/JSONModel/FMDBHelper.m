//
//  FMDBHelper.m
//  JSONModelDemo_iOS
//
//  Created by zhou on 14-5-1.
//  Copyright (c) 2014年 Underplot ltd. All rights reserved.
//

#import "FMDBHelper.h"
#import <FMDatabaseQueue.h>
#import "JSONModel.h"


@interface FMDBHelper ()

@property (strong, nonatomic) NSString       *dbPath;
#if OS_OBJECT_HAVE_OBJC_SUPPORT == 1
@property (strong, nonatomic) dispatch_queue_t       serialQueue;
#else
@property (assign, nonatomic) dispatch_queue_t       serialQueue;
#endif

@end

static NSString *const kJMFileNameDefaultDataBase = @"jm_default.db";

@implementation FMDBHelper

static id sharedInstance = nil;

+ (instancetype)sharedInstance;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 *  删除数据库文件
 */
+ (void)deleteDataBaseFile
{

    [[FMDBHelper sharedInstance] close];
    sharedInstance = nil;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath = [[self __documentsDir] stringByAppendingPathComponent:kJMFileNameDefaultDataBase];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:dataPath error:&error];
    if (!success) {
        NSLog(@"Could not delete %@ database file -:%@ ", kJMFileNameDefaultDataBase, [error localizedDescription]);
    }
    
}

- (void)dealloc
{
    [self close];
}

- (id)init
{
    NSString *dataPath = [[[self class] __documentsDir] stringByAppendingPathComponent:kJMFileNameDefaultDataBase];
    self = [FMDBHelper databaseWithPath:dataPath];
    self.dbPath = dataPath;
    if (![self open]) {
        NSLog(@"Could not open Database: '%@'", [self lastErrorMessage]);
    }
    self.serialQueue = dispatch_queue_create("com.zqnetwork", DISPATCH_QUEUE_SERIAL);
    return self;
}

+ (NSString *)__documentsDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

#pragma mark - 

- (FMResultSet *)JM_executeQuery:(NSString*)sql;
{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wformat-nonliteral"
    __block FMResultSet *rsl = nil;
    dispatch_sync(_serialQueue, ^{
        rsl = [self executeQuery:sql];
    });
    return rsl;
//#pragma clang diagnostic pop
}

- (void)JM_executeQuery:(NSString*)sql block:(FMDBCompletionBlock)block;
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    __block FMResultSet *rsl = nil;
    dispatch_async(_serialQueue, ^{
        rsl = [self executeQuery:sql];
        block(nil, rsl);
    });
#pragma clang diagnostic pop
 
}

- (BOOL)JM_executeStatements:(NSString *)sql{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    BOOL ret = [self executeStatements:sql];
    return ret;
#pragma clang diagnostic pop
    
}

- (BOOL)JM_executeStatements:(NSString *)sql block:(FMDBExecuteStatementsCallbackBlock)block
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    BOOL ret = [self executeStatements:sql withResultBlock:block];
    return ret;
#pragma clang diagnostic pop
    
}

- (BOOL)JM_executeUpdate:(NSString *)sql
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    NSLog(@"%@", sql);
    __block BOOL ret = NO;
    dispatch_sync(_serialQueue, ^{
        ret = [self executeUpdate:sql];
    });
    return ret;
#pragma clang diagnostic pop
}

- (void)JM_executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params completion:(FMDBUpdateCompletionBlock)block
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    dispatch_sync(_serialQueue, ^{
        BOOL suc = [self executeUpdate:sql withArgumentsInArray:params];
        if (suc) {
            block(nil);
        } else {
            NSError *err = [NSError errorWithDomain:@"fmdb"
                                               code:-1
                                           userInfo:@{@"msg":@"update failed"}];
            block(err);
        }
    });
#pragma clang diagnostic pop
}

- (BOOL)JM_executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)params
{
    __block BOOL ret = NO;
    dispatch_sync(_serialQueue, ^{
        ret = [self executeUpdate:sql withArgumentsInArray:params];
    });
    return ret;
}

- (void)JM_executeUpdate:(NSString*)sql block:(FMDBCompletionBlock)block;
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat-nonliteral"
    
//    __weak NSString *weakSql = sql;
//    __block FMDBCompletionBlock blockCp = block;
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
//    [queue inDatabase:^(FMDatabase *adb) {
//        BOOL ret = [adb executeUpdateWithFormat:@"%@", weakSql];
//        if(ret) {
//            if(blockCp)
//                blockCp(nil, nil);
//        } else {
//            NSError *err =  [NSError errorWithDomain:@"data update err"
//                                              code:1
//                                          userInfo:nil];
//            if(blockCp)
//                blockCp(err, nil);
//        }
//        [adb close];
//    }];

#pragma clang diagnostic pop

}

@end
