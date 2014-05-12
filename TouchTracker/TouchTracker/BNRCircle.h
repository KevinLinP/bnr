//
//  BNRCircle.h
//  TouchTracker
//
//  Created by Kevin Lin on 5/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRCircle : NSObject

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat angleInRadians;

- (void)setFromFirstPoint:(CGPoint)loc1
         secondPoint:(CGPoint)loc2;

@end
