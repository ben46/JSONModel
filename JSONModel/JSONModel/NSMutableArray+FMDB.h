//
//  NSMutableArray+FMDB.h
//  JSONModelDemo_iOS
//
//  Created by nobby heell on 2019/1/6.
//  Copyright © 2019年 Zhuoqian Zhou ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (FMDB)

- (void)JM_saveAsync:(FMDBUpdateCompletionBlock)block;

@end

NS_ASSUME_NONNULL_END
