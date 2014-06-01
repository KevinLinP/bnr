//
//  BNRImageUIPopoverBackgroundView.m
//  Homepwner
//
//  Created by Kevin Lin on 6/1/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageUIPopoverBackgroundView.h"

@interface BNRImageUIPopoverBackgroundView ()

@property (nonatomic) UIPopoverArrowDirection _arrowDirection;
@property (nonatomic) CGFloat _arrowOffset;

@end

@implementation BNRImageUIPopoverBackgroundView

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
}

- (CGFloat)arrowOffset
{
    return self._arrowOffset;
}

- (void)setArrowOffset:(CGFloat)arrowOffset
{
    self._arrowOffset = arrowOffset;
}

- (UIPopoverArrowDirection)arrowDirection
{
    return self._arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
    self._arrowDirection = arrowDirection;
}

+ (CGFloat)arrowHeight
{
    return 5.0;
}

+ (CGFloat)arrowBase
{
    return 5.0;
}

@end
