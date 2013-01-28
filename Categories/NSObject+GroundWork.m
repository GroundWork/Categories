//
//  NSObject+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "NSObject+GroundWork.h"

@implementation NSObject (GroundWork)
- (void)executeBlock:(GWBlock)block withCallback:(GWBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block(self);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(self);
        });
    });
}

+ (void)executeBlock:(GWBlock)block withCallback:(GWBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block(nil);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(nil);
        });
    });    
}

- (void)executeBlock:(GWBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block(self);
    });
}

+ (void)executeBlock:(GWBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block(nil);
    });
}

@end
