//
//  AppDelegate.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 02/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "AppDelegate.h"
//#import "MasterViewController.h"
#import "JSONModel.h"
#import "FMDBHelper.h"
#import <FMDatabaseQueue.h>

@interface TModel : JSONModel

@property (strong, nonatomic) NSString<JMUnique>  *userName;
//@property (strong, nonatomic) NSString<JMText>  *desc;
@property (strong, nonatomic) NSString  *psw;
@property (strong, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSDecimalNumber *groupID;

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

//    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
//    self.window.rootViewController = self.navigationController;
    
    TModel *model = [[TModel alloc] initWithDictionary:@{@"userName": @"zhou",
                                                               @"psw":@"123",
                                                               @"ID":@1,
                                                               @"isVIP":@1,
                                                               @"updateAt":@1234234,
                                                               @"money":@11.1,
                                                               @"followerCount": @3
                                                               }
                                                       error:nil];
    [model JM_saveAsync:nil];
    
    TModel *model1 = [TModel JM_find:@1];
    NSLog(@"%@", [model1 toDictionary]);

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
