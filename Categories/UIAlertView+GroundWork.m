//
//  UIAlertView+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIAlertView+GroundWork.h"
#import <objc/runtime.h>

@implementation UIAlertView (GroundWork)
static char GW_BLOCK_KEY;
static char GW_DELEGATE_KEY;
@dynamic elements;
@dynamic gwDelegate;

- (void)setElements:(NSMutableDictionary *)elements
{
    objc_setAssociatedObject(self, &GW_BLOCK_KEY, elements, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)elements
{
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &GW_BLOCK_KEY);
}

- (void)setGwDelegate:(id<UIAlertViewDelegate>)gwDelegate
{
    objc_setAssociatedObject(self, &GW_DELEGATE_KEY, gwDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIAlertViewDelegate>)gwDelegate
{
    return (id<UIAlertViewDelegate>)objc_getAssociatedObject(self, &GW_DELEGATE_KEY);
}

#pragma mark - Public init/create methods
+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    return alert;   
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message callback:(GWAlertBlock)callback
{
    UIAlertView *alertView = [UIAlertView alertViewWithTitle:title message:message];
    [alertView setCancelButtonTitle:@"OK" callback:callback];
    
    return alertView;
}

#pragma mark - UIAlertView Delegate Methods -
- (void)alertViewCancel:(UIAlertView *)alertView
{
    if(self.gwDelegate && [self.gwDelegate respondsToSelector:@selector(alertViewCancel:)])
        [self.gwDelegate alertViewCancel:alertView];
    
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.gwDelegate && [self.gwDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
        [self.gwDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.gwDelegate && [self.gwDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
        [self.gwDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if(self.gwDelegate && [self.gwDelegate respondsToSelector:@selector(willPresentAlertView:)])
        [self.gwDelegate willPresentAlertView:alertView];
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if(self.gwDelegate && [self.gwDelegate respondsToSelector:@selector(didPresentAlertView:)])
        [self.gwDelegate didPresentAlertView:alertView];
}

#pragma - Helper and Setup Methods -
- (void)setup
{
    if(self.elements == NULL)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [self setElements:dict];
    }
    
    if(self.gwDelegate == NULL)
    {
        [self setGwDelegate:self.delegate];
        [self setDelegate:self];
    }
}

- (NSUInteger)gwAddButtonWithTitle:(NSString *)title block:(GWAlertBlock)block
{
    [self setup];
    
    NSInteger idx   = [self addButtonWithTitle:title];
    NSNumber *index = [NSNumber numberWithInteger:idx];
    
    [[self elements] setObject:block forKey:index];
    
    return idx;
}


#pragma mark - Public Methods -
- (void)setCancelButtonTitle:(NSString *)title callback:(GWAlertBlock)callback
{
    self.cancelButtonIndex = [self gwAddButtonWithTitle:title block:callback];
}

- (void)addButtonWithTitle:(NSString *)title action:(GWAlertBlock)action
{
    [self gwAddButtonWithTitle:title block:action];
}


@end
