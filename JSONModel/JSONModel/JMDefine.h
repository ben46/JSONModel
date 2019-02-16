//
//  JMDefine.h
//  JSONModelDemo_iOS
//
//  Created by nobby heell on 2019/1/5.
//  Copyright © 2019年 Zhuoqian Zhou ltd. All rights reserved.
//

#ifndef JMDefine_h
#define JMDefine_h
@class FMResultSet;
typedef void(^FMDBCompletionBlock)(NSError *err, FMResultSet* rsl);
typedef void(^FMDBUpdateCompletionBlock)(NSError *err);
typedef void(^JMSQLMakeCompletion)(NSString *sql, NSMutableArray* params);
typedef void(^JMFindCompletionBlock)(id obj);
typedef void(^JMCompletionBlock)(id result);


#endif /* JMDefine_h */
