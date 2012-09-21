//
//  UIControl+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIControl+GroundWork.h"
#import <objc/runtime.h>
#import "NSArray+GroundWork.h"

@interface GWControlActionWrapper : NSObject
@property (copy) GWControlBlock block;
@property (assign) UIControlEvents event;
+ (GWControlActionWrapper *)controlActionWrapperWithBlock:(GWControlBlock)block forEvent:(UIControlEvents)event;
- (void)callControlBlockWithSender:(id)sender;
@end


@implementation GWControlActionWrapper
+ (GWControlActionWrapper *)controlActionWrapperWithBlock:(GWControlBlock)block forEvent:(UIControlEvents)event
{
    GWControlActionWrapper *this = [[GWControlActionWrapper alloc] init];
    this.block = block;
    this.event = event;
    
    return this;
}

- (void)callControlBlockWithSender:(id)sender
{
    if(self.block)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.block(sender);
        });
    }
}
@end

@implementation UIControl (GroundWork)
- (void)bindEvent:(UIControlEvents)event action:(GWControlBlock)action
{
    NSMutableArray *events = objc_getAssociatedObject(self, "GW_CONTROL_EVENT");
    if(!events)
    {
        events = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, "GW_CONTROL_EVENT", events, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    GWControlActionWrapper *wrapper = [GWControlActionWrapper controlActionWrapperWithBlock:action forEvent:event];
    [events addObject:wrapper];
    [self addTarget:wrapper action:@selector(callControlBlockWithSender:) forControlEvents:event];
}

- (void)unbindEvent:(UIControlEvents)event
{
    NSMutableArray *events = objc_getAssociatedObject(self, "GW_CONTROL_EVENT");
    if(events)
    {
        [events removeObjectsInArray:[events filterWithBlock:^BOOL(id object) {
            if([object isKindOfClass:[GWControlActionWrapper class]])
                return ([(GWControlActionWrapper *)object event] == event);
            
            return NO;
        }]];
    }
}
@end
