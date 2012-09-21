//
//  NSArray+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "NSArray+GroundWork.h"

@implementation NSArray (GroundWork)
- (NSArray *)filterWithBlock:(BOOL(^)(id object))block
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       if(block(obj))
           [results addObject:obj];
    }];
    
    return (results.count > 0)? [results copy] : nil;
}
@end

@implementation NSMutableArray(GroundWork)
- (id)pop
{
    id object = [self lastObject];
    [self removeLastObject];

    return object;
}

- (id)shift
{
    id object = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
    return object;
}
@end