//
//  NSString+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

@interface NSString (GroundWork)
- (NSString *)URLEncode;
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;
- (NSString *)stringByRemovingHTML;
- (NSString *)capitalizeFirstLetter;
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)summarizeString:(NSInteger)length;
- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;
+ (NSString *)uuid;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
@end
