//
//  UILabel+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//



@interface UILabel (GroundWork)
- (void)alignToTop;
- (void)alignToBottom;
- (void)sizeToFitFixedWidth:(NSInteger)width;
- (void)adjustHeightForString:(NSString *)string;
- (void)adjustHeightForText;
@end
