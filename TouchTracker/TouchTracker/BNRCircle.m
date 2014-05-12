//
//  BNRCircle.m
//  TouchTracker
//
//  Created by Kevin Lin on 5/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRCircle.h"
#import "BNRLine.h"

@implementation BNRCircle

- (void)setFromFirstPoint:(CGPoint)loc1
         secondPoint:(CGPoint)loc2
{
    self.center = CGPointMake((loc1.x + loc2.x) / 2, (loc1.y + loc2.y) / 2);
    
    CGFloat xDist = abs(loc2.x - loc1.x);
    CGFloat yDist = abs(loc2.y - loc1.y);
    
    if (xDist > yDist) {
        self.radius = xDist / 2;
    } else {
        self.radius = yDist / 2;
    }
    
    BNRLine *line = [[BNRLine alloc] init];
    line.begin = loc1;
    line.end = loc2;
    self.angleInRadians = line.angleInRadians;
}

@end