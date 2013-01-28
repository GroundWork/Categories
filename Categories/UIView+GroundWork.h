//
//  UIView+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

@interface NSShadow(GroundWork)
@property (readwrite, nonatomic) NSInteger opacity;
+ (NSShadow *)shadowWithOffset:(CGSize)offset color:(UIColor *)color radius:(CGFloat)radius opacity:(NSInteger)opacity;
@end

NSShadow *NSShadowCreate(CGSize offset, UIColor *color, CGFloat radius, NSInteger opacity);

typedef void(^GWDrawRectBlock) (CGRect rect);

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
@property (nonatomic)           NSShadow  *shadow;

- (UIImage *)rasterizedToImage;
+ (UIView *)viewWithFrame:(CGRect)rect drawRect:(GWDrawRectBlock)block;

@end
