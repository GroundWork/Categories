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
@end
