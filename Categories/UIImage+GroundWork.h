//
//  UIImage+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

typedef void(^GWImageBlock)(UIImage *image);

typedef enum
{
    GWImageResizeCrop,
    GWImageResizeCropStart,
    GWImageResizeCropEnd,
    GWImageResizeScale
} GWImageResizeTypes;

@interface UIImage (GroundWork)
@property (readonly, nonatomic) CGFloat width;
@property (readonly, nonatomic) CGFloat height;

- (UIImage *)imageAdjustToSize:(CGSize)size type:(GWImageResizeTypes)type;
- (UIImage *)imageCroppedToSize:(CGSize)size;
- (UIImage *)imageScaledToSize:(CGSize)size;
- (UIImage *)fillImageWithColor:(UIColor *)color;
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
+ (UIImage *)imageFromURL:(id)url;
+ (void)imageFromURL:(id)url callback:(GWImageBlock)callback;
@end
