//
//  BNRLine.m
//  TouchTracker
//
//  Created by Kevin Lin on 5/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

- (CGFloat)angleInRadians
{
    CGFloat deltaY = self.end.y - self.begin.y;
    CGFloat deltaX = self.end.x - self.begin.x;
    
    return atan2(deltaY, deltaX);
}

@end
