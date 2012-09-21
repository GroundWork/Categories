//
//  UILabel+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "UILabel+GroundWork.h"

@implementation UILabel (GroundWork)
- (void)alignToTop
{
    CGSize fontSize         = [self.text sizeWithFont:self.font];
    double finalHeight      = fontSize.height * self.numberOfLines;
    double finalWidth       = self.frame.size.width;
    CGSize theStringSize    = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad       = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignToBottom
{
    CGSize fontSize         = [self.text sizeWithFont:self.font];
    double finalHeight      = fontSize.height * self.numberOfLines;
    double finalWidth       = self.frame.size.width;
    CGSize theStringSize    = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad       = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

- (void)sizeToFitFixedWidth:(NSInteger)width
{
    self.frame          = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, 0);
    
#ifdef __IPHONE_6_0
	self.lineBreakMode  = NSLineBreakByWordWrapping;
#else
    self.lineBreakMode  = UILineBreakModeWordWrap; //NSLineBreakByWordWrapping
#endif
    
    self.numberOfLines  = 0;
    
    [self sizeToFit];
}

- (void)adjustHeightForString:(NSString *)string
{
    CGSize maximumLabelSize     = CGSizeMake(self.frame.size.width,9999);
    CGSize expectedLabelSize    = [string sizeWithFont:self.font constrainedToSize:maximumLabelSize lineBreakMode:self.lineBreakMode];
    
    CGRect newFrame             = self.frame;
    newFrame.size.height        = expectedLabelSize.height;
    self.frame                  = newFrame;
}

- (void)adjustHeightForText
{
    [self adjustHeightForString:self.text];
}
@end
