//
//  UIView+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIView+GroundWork.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (GroundWork)
#pragma mark - Getters

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)top
{
    return self.y;
}

- (CGFloat)left
{
    return self.x;
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


#pragma mark - Setters

- (void)setOrigin:(CGPoint)_origin
{
    CGRect frame    = self.frame;
    frame.origin    = _origin;
    self.frame      = frame;
}


- (void)setSize:(CGSize)_size
{
    CGRect frame    = self.frame;
    frame.size      = _size;
    self.frame      = frame;
}

- (void)setY:(CGFloat)_y
{
    CGRect frame    = self.frame;
    frame.origin.y  = _y;
    self.frame      = frame;
}

- (void)setTop:(CGFloat)y
{
    [self setY:y];
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)x
{
    [self setX:x];
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame        = self.frame;
    frame.size.width    = width;
    self.frame          = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame        = self.frame;
    frame.size.height   = height;
    self.frame          = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIImage *)rasterizedToImage
{
    UIGraphicsBeginImageContext(self.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *rasterizedView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rasterizedView;
}


@end
