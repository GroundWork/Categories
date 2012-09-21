//
//  UIGestureRecognizer+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIGestureRecognizer+GroundWork.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (GroundWork)
- (void)executeAction:(id)sender
{
    GWGestureBlock block = objc_getAssociatedObject(self, "GW_GESTURE_ACTION");
    block(sender);
}

+ (id)gestureRecognizerWithAction:(GWGestureBlock)action
{
    return [[[self class] alloc] initWithAction:action];
}

- (id)initWithAction:(GWGestureBlock)action
{
    self = [self initWithTarget:self action:@selector(executeAction:)];
    objc_setAssociatedObject(self, "GW_GESTURE_ACTION", action, OBJC_ASSOCIATION_COPY);
    
    return self;
}
@end
