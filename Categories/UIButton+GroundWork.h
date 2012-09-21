//
//  UIButton+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//



@interface UIButton (GroundWork)
@property (strong, nonatomic) NSMutableDictionary *backgrounds;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
