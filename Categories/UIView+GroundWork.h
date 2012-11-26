//
//  UIView+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

@interface UIView (GroundWork)
@property (nonatomic)           CGPoint   origin;
@property (nonatomic)           CGSize    size;
@property (nonatomic)           CGFloat   y;
@property (nonatomic)           CGFloat   top;
@property (nonatomic)           CGFloat   x;
@property (nonatomic)           CGFloat   left;
@property (nonatomic)           CGFloat   right;
@property (nonatomic)           CGFloat   bottom;
@property (nonatomic)           CGFloat   width;
@property (nonatomic)           CGFloat   height;
@property (nonatomic)           CGFloat   cornerRadius;
@property (nonatomic)           CGFloat   borderWidth;
@property (nonatomic, strong)   UIColor   *borderColor;
@property (assign, nonatomic)   NSArray   *gradientBackgroundColors;

- (UIImage *)rasterizedToImage;

@end
