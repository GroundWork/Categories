//
//  NSDictionary+GroundWork.m
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

#import "NSDictionary+GroundWork.h"

@implementation NSDictionary (GroundWork)
@dynamic httpQueryString;

- (NSString *)httpQueryString
{
    NSMutableArray *query = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [query addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    
    return [query componentsJoinedByString:@"&"];
}

+ (NSDictionary *) dictionaryFromJSONString:(NSString *)jsonString
{
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONWritingPrettyPrinted error:&error];
    NSAssert(error == nil, @"DictionaryFromJSONString Error: %@", error.description);
    
    return result;
}

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)url
{
    NSData *data    = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSError *error  = nil;
    id result       = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSAssert(error == nil, @"dictionaryWithContentsOfJSONURLString Error: %@", error.description);
    
    return result;
}

- (NSData *)toJSONData
{
    NSError *error      = nil;
    NSData *jsonData    = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    NSAssert(error == nil, @"toJSONData Error: %@", error.description);
    
    return jsonData;
}

- (NSString *)toJSONString
{
    NSData *jsonData        = [self toJSONData];
    NSString *jsonString    = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
