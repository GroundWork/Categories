//
//  NSArray+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

@interface NSArray (GroundWork)
- (NSArray *)filterWithBlock:(BOOL(^)(id object))block;
@end

@interface NSMutableArray (GroundWork)
- (id)pop;
- (id)shift;
@end
