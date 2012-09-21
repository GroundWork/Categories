//
//  UIGestureRecognizer+GroundWork.h
//  Categories
//
//  Created by Wess Cope on 9/21/12.
//  Copyright (c) 2012 GroundWork. All rights reserved.
//

typedef void(^GWGestureBlock)(UIGestureRecognizer *gesture);

@interface UIGestureRecognizer (GroundWork)
+ (id)gestureRecognizerWithAction:(GWGestureBlock)action;
- (id)initWithAction:(GWGestureBlock)action;
@end
