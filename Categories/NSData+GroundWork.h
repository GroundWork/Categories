//
//  NSData+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//



@interface NSData (GroundWork)
+ (NSData *) dataFromBase64EncodedString:(NSString *)string;
- (id) initFromBase64EncodedString:(NSString *)string;
- (NSString *) base64EncodeWithLength:(unsigned int)length;
@end
