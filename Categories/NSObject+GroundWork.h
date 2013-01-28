//
//  NSObject+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

typedef void(^GWBlock)(id this);

@interface NSObject (GroundWork)
- (void)executeBlock:(GWBlock)block withCallback:(GWBlock)callback;
+ (void)executeBlock:(GWBlock)block withCallback:(GWBlock)callback;

- (void)executeBlock:(GWBlock)block afterDelay:(NSTimeInterval)delay;
+ (void)executeBlock:(GWBlock)block afterDelay:(NSTimeInterval)delay;
@end
