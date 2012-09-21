//
//  UIAlertView+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

typedef void(^GWAlertBlock)(void);

@interface UIAlertView (GroundWork)
@property (strong, nonatomic) NSMutableDictionary *elements;
@property (strong, nonatomic) id<UIAlertViewDelegate>gwDelegate;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message;
+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message callback:(GWAlertBlock)callback;
- (void)setCancelButtonTitle:(NSString *)title callback:(GWAlertBlock)callback;
- (void)addButtonWithTitle:(NSString *)title action:(GWAlertBlock)action;

@end
