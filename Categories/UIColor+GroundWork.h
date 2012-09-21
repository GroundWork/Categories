//
//  UIColor+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

@interface UIColor (GroundWork)
+ (UIColor *)fromHexString:(NSString *)hexString;
+ (UIColor *)randomColor;
- (UIColor *)colorByChangingAlphaTo:(CGFloat)alpha;
- (UIColor *)invertColor;

@end
