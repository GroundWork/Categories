//
//  NSString+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "NSString+GroundWork.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GroundWork)
- (NSString *)URLEncode
{
    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL,(CFStringRef)@":/=,!$&'()*+;[]@#?",  kCFStringEncodingUTF8);
    NSString *returnString = (__bridge NSString *)strRef;
    CFRelease(strRef);
    
    return returnString;
}

- (NSString *)escapeHTML
{
	NSMutableString *s  = [NSMutableString string];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	int start           = 0;
	int len             = [self length];
    
	while (start < len)
    {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound)
        {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
        
		if (start < r.location)
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
        
		switch ([self characterAtIndex:r.location])
        {
			case '<':
				[s appendString:@"&lt;"];
                break;
                
            case '>':
				[s appendString:@"&gt;"];
                break;
                
			case '"':
				[s appendString:@"&quot;"];
                break;
                
			case '&':
				[s appendString:@"&amp;"];
                break;
		}
        
		start = r.location + 1;
	}
    
	return s;
}

- (NSString *)unescapeHTML
{
	NSMutableString *s      = [NSMutableString string];
	NSMutableString *target = [self mutableCopy];
	NSCharacterSet *chs     = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    
	while ([target length] > 0)
    {
		NSRange r = [target rangeOfCharacterFromSet:chs];
        
        if (r.location == NSNotFound)
        {
			[s appendString:target];
			break;
		}
        
		if (r.location > 0)
        {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
        
		if ([target hasPrefix:@"&lt;"])
        {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		}
        else if ([target hasPrefix:@"&gt;"])
        {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		}
        else if ([target hasPrefix:@"&quot;"])
        {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		}
        else if ([target hasPrefix:@"&#39;"])
        {
			[s appendString:@"'"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		}
        else if ([target hasPrefix:@"&amp;"])
        {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		}
        else if ([target hasPrefix:@"&hellip;"])
        {
			[s appendString:@"…"];
			[target deleteCharactersInRange:NSMakeRange(0, 8)];
		}
        else
        {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
    
	return s;
}


- (NSString*)stringByRemovingHTML
{
    
	NSString *html          = self;
    NSScanner *thescanner   = [NSScanner scannerWithString:html];
    NSString *text          = nil;
    
    while (![thescanner isAtEnd])
    {
		[thescanner scanUpToString:@"<" intoString:NULL];
		[thescanner scanUpToString:@">" intoString:&text];
		
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
	return html;
}

- (NSString *)capitalizeFirstLetter
{
    if(![self isEqualToString:@""])
    {
        NSString *firstCapChar = [[self substringToIndex:1] capitalizedString];
        NSString *cappedString = [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstCapChar];
        
        return cappedString;
    }
    
    return self;
}

- (NSString *)summarizeString:(NSInteger)length
{
    if(length > self.length)
        return self;
    
    NSMutableArray *result  = [NSMutableArray array];
    NSArray *words          = [self componentsSeparatedByString:@" "];
    
    NSInteger cnt = 0;
    for(NSString *word in words)
    {
        if(cnt == length)
            break;
        
        [result addObject:word];
    }
    
    [result addObject:@"…"];
    
    return [words componentsJoinedByString:@" "];
}

- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font
{
    NSString *ellipsis                  = @"…";
    NSMutableString *truncatedString    = [self mutableCopy];
    
    if ([self sizeWithFont:font].width > width)
    {
        width        -= [ellipsis sizeWithFont:font].width;
        NSRange range = {truncatedString.length - 1, 1};
        
        while ([truncatedString sizeWithFont:font].width > width)
        {
            [truncatedString deleteCharactersInRange:range];
            range.location--;
        }
        
        [truncatedString replaceCharactersInRange:range withString:ellipsis];
    }
    
    return truncatedString;
}

- (NSString *)md5
{
	const char *cStr = [self UTF8String];
	unsigned char digest[16];
	CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
    
	return  output;
}

- (NSString *)sha1
{
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data 	 = [NSData dataWithBytes:cstr length:self.length];
    
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
	CC_SHA1(data.bytes, data.length, digest);
    
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
    
	return output;
}

+ (NSString *) uuid
{
	CFUUIDRef puuid         = CFUUIDCreate( nil );
	CFStringRef uuidString  = CFUUIDCreateString( nil, puuid );
    NSString *result        = (__bridge NSString *)CFStringCreateCopy( NULL, uuidString);
    
	CFRelease(puuid);
    CFRelease(uuidString);
    
	return result;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

@end
