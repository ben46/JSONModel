//
//  AppDelegate.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 02/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "JSONModel.h"
#import "FMDBHelper.h"
#import <FMDatabaseQueue.h>


@protocol SubModel <NSObject>
@end

@interface SubModel : JSONModel

@property (strong, nonatomic) NSNumber<JMPrimaryKey>       *ID;
@property (strong, nonatomic) NSString       *name;

@end

@implementation SubModel
@end

#pragma mark -

@interface TModel : JSONModel

//@property (strong, nonatomic) NSString<JMUnique>  *userName;
@property (strong, nonatomic) NSString  *userName;
//@property (strong, nonatomic) NSString<JMText>  *desc;
@property (strong, nonatomic) NSString  *psw;
@property (strong, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSDecimalNumber *groupID;
@property (strong, nonatomic) NSArray<SubModel>       *list;

@property (assign, nonatomic) NSInteger followerCount;
@property (assign, nonatomic) int isVIP;
@property (assign, nonatomic) NSTimeInterval updateAt;
@property (assign, nonatomic) double money;
@property (assign, nonatomic) float moneyf;
@property (assign, nonatomic) long hahalong;
@property (assign, nonatomic) short hahashort;
@property (assign, nonatomic) NSUInteger hahaUint;


@end

@implementation TModel
@end

@implementation AppDelegate

- (void)test1{
//    [FMDBHelper deleteDataBaseFile];
    TModel *model = [[TModel alloc] initWithDictionary:@{
                                                         @"userName": @"zhou",
                                                         @"psw":@"123",
                                                         @"ID":@3,
                                                         @"isVIP":@1,
                                                         @"updateAt":@1234234,
                                                         @"money":@11.1,
                                                         @"followerCount": @3
//                                                         @"list":@[
//                                                                 @{
//                                                                     @"ID":@1,
//                                                                     @"name":@"hello i am #1"
//                                                                     },
//                                                                 @{
//                                                                     @"ID":@2,
//                                                                     @"name":@"i am #2"
//                                                                     }
//                                                                 ]
                                                         }
                                                 error:nil];
//    [model JM_save];
    [model JM_insert];
//    [model JM_update];
    TModel *result = [TModel JM_find:@2];
    NSLog(@"%@", result);
    
//    [model JM_saveAsync:^(NSError *err){
//        if (err) {
//            NSLog(@"%@", err);
//        }
//
////        [TModel JM_asyncFindValue:@1 withResultObj:^(TModel *model1 ){
////            NSLog(@"%@", [model1 toDictionary]);
////            [FMDBHelper deleteDataBaseFile];
////        }];
//    }];
    
}
-(void)test2{
    
    //    sqlite3_prepare(db,
    //                    "INSERT INTO players (name,num) VALUES(?,?);",
    //                    -1,&stmt,&zTail);
    //    char str[] = "Kevin";
    //    int n = 23;
    //    sqlite3_bind_text(stmt,1,str,-1,SQLITE_STATIC); //绑定数据
    //    sqlite3_bind_int(stmt,2,n);
    //    r = sqlite3_step(stmt);
    //    if ( r!=SQLITE_DONE) {
    //        printf("%s",sqlite3_errmsg(db));
    //    }
    //    sqlite3_reset(stmt);         //重新复位下stmt语句
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    
    [self test1];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
