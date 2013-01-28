//
//  UIImage+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UIImage+GroundWork.h"

@implementation UIImage (GroundWork)

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)height
{
    return self.size.height;
}

- (UIImage *)imageAdjustToSize:(CGSize)size type:(GWImageResizeTypes)type
{
    CGFloat imageScaleFactor    = self.scale;
    CGFloat sourceWidth         = (self.size.width * imageScaleFactor);
    CGFloat sourceHeight        = (self.size.width * imageScaleFactor);
    CGFloat targetWidth         = size.width;
    CGFloat targetHeight        = size.height;
    BOOL cropping               = !(type == GWImageResizeScale);
    CGFloat sourceRatio         = sourceWidth / sourceHeight;
    CGFloat targetRatio         = targetWidth / targetHeight;
    BOOL scaleWidth             = (sourceRatio <= targetRatio);

    scaleWidth = (cropping) ? scaleWidth : !scaleWidth;
    
    CGFloat scalingFactor, scaledWidth, scaledHeight;
    if (scaleWidth)
    {
        scalingFactor   = 1.0 / sourceRatio;
        scaledWidth     = targetWidth;
        scaledHeight    = round(targetWidth * scalingFactor);
    }
    else
    {
        scalingFactor   = sourceRatio;
        scaledWidth     = round(targetHeight * scalingFactor);
        scaledHeight    = targetHeight;
    }
    
    float scaleFactor = scaledHeight / sourceHeight;

    CGRect sourceRect, destRect;
    if (cropping)
    {
        destRect = CGRectMake(0, 0, targetWidth, targetHeight);
        CGFloat destX = 0, destY = 0;
        if (type == GWImageResizeCrop)
        {
            destX = round((scaledWidth - targetWidth) / 2.0);
            destY = round((scaledHeight - targetHeight) / 2.0);
        }
        else if (type == GWImageResizeCropStart)
        {
            if (scaleWidth)
            {
				destX = 0.0;
				destY = 0.0;
            }
            else
            {
                destX = 0.0;
				destY = round((scaledHeight - targetHeight) / 2.0);
            }
        }
        else if (type == GWImageResizeCropEnd)
        {
            if (scaleWidth)
            {
				destX = round((scaledWidth - targetWidth) / 2.0);
				destY = round(scaledHeight - targetHeight);
            }
            else
            {
				destX = round(scaledWidth - targetWidth);
				destY = round((scaledHeight - targetHeight) / 2.0);
            }
        }
        
        CGFloat sourceRectX         = (destX / scaleFactor),
                sourceRectY         = (destY / scaleFactor),
                sourceRectWidth     = (targetWidth / scaleFactor),
                sourceRectHeight    = (targetHeight / scaleFactor);
        
        sourceRect = CGRectMake(sourceRectX, sourceRectY, sourceRectWidth, sourceRectHeight);
    }
    else
    {
        sourceRect  = CGRectMake(0, 0, sourceWidth, sourceHeight);
        destRect    = CGRectMake(0, 0, scaledWidth, scaledHeight);
    }
    
    // Create appropriately modified image.
	UIImage *image = nil;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
		UIGraphicsBeginImageContextWithOptions(destRect.size, NO, 0.0);
	
        CGImageRef sourceImg = CGImageCreateWithImageInRect([self CGImage], sourceRect);
		image = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:self.imageOrientation];
		
        [image drawInRect:destRect];
		CGImageRelease(sourceImg);
		
        image = UIGraphicsGetImageFromCurrentImageContext();
		
        UIGraphicsEndImageContext();
	}
	
    return image;
}


- (UIImage *)imageCroppedToSize:(CGSize)size
{
    return [self imageAdjustToSize:size type:GWImageResizeCrop];
}

- (UIImage *)imageScaledToSize:(CGSize)size;
{
    return [self imageAdjustToSize:size type:GWImageResizeScale];
}

- (UIImage *)fillImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
    CGRect rect = CGRectZero;
    rect.size   = self.size;
    
    [color set];
    UIRectFill(rect);
    
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *filledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return filledImage;
}

- (BOOL)hasAlpha
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst                 ||
            alpha == kCGImageAlphaLast                  ||
            alpha == kCGImageAlphaPremultipliedFirst    ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)imageWithAlpha
{
    if ([self hasAlpha])
        return self;
    
    CGImageRef imageRef             = self.CGImage;
    size_t width                    = CGImageGetWidth(imageRef);
    size_t height                   = CGImageGetHeight(imageRef);
    CGContextRef offscreenContext   = CGBitmapContextCreate(NULL, width, height, 8, 0, CGImageGetColorSpace(imageRef), kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);

    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    
    CGImageRef imageRefWithAlpha    = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha         = [UIImage imageWithCGImage:imageRefWithAlpha];

    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

- (UIImage *)transparentBorderImage:(NSUInteger)borderSize
{
    UIImage *image          = [self imageWithAlpha];
    CGRect newRect          = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    CGContextRef bitmap     = CGBitmapContextCreate(NULL, newRect.size.width, newRect.size.height, CGImageGetBitsPerComponent(self.CGImage), 0, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(self.CGImage));
    CGRect imageLocation    = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);

    CGContextDrawImage(bitmap, imageLocation, self.CGImage);

    CGImageRef borderImageRef               = CGBitmapContextCreateImage(bitmap);
    CGImageRef maskImageRef                 = [self newBorderMask:borderSize size:newRect.size];
    CGImageRef transparentBorderImageRef    = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage         = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

+ (UIImage *)imageFromURL:(id)url
{
    NSAssert([url isKindOfClass:[NSString class]] || [url isKindOfClass:[NSURL class]], @"UIImage imageFromURL invalid argument type");
    
    NSURL *imageURL = ([url isKindOfClass:[NSString class]])? [NSURL URLWithString:url] : url;
    
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
}

+ (void)imageFromURL:(id)url callback:(GWImageBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       UIImage *image = [UIImage imageFromURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(image);
        });
    });
}

#pragma mark - Private helper methods
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef maskContext = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaNone);

    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));

    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);

    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}


@end
