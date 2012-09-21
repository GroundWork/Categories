//
//  UIButton+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIButton+GroundWork.h"
#import <objc/runtime.h>

@implementation UIButton (GroundWork)
static char GW_BACKGROUNDS_KEY;
@dynamic backgrounds;

- (void)setBackgrounds:(NSMutableDictionary *)backgrounds
{
    objc_setAssociatedObject(self, &GW_BACKGROUNDS_KEY, backgrounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)backgrounds
{
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &GW_BACKGROUNDS_KEY);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if([self backgrounds] == NULL)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [self setBackgrounds:dict];
    }
    
    [self.backgrounds setObject:backgroundColor forKey:[NSNumber numberWithInt:state]];
    
    if(!self.backgroundColor)
        self.backgroundColor = backgroundColor;
}


#pragma mark - Background Color Toggle Methods -
- (void)animateBackgroundToColor:(NSNumber *)key
{
    UIColor *background = [[self backgrounds] objectForKey:key];
    if(background)
    {
        [UIView animateWithDuration:0.1f animations:^{
            self.backgroundColor = background;
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateHighlighted]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}
@end
