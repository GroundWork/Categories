//
//  UIControl+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

typedef void(^GWControlBlock)(id sender);

@interface UIControl (GroundWork)
- (void)bindEvent:(UIControlEvents)event action:(GWControlBlock)action;
- (void)unbindEvent:(UIControlEvents)event;
@end
