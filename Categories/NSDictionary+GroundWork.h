//
//  NSDictionary+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//



@interface NSDictionary (GroundWork)
+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString;
+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)url;

- (NSData *)toJSONData;
- (NSString *)toJSONString;
@end
