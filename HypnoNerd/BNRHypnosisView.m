//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Kevin Lin on 2/28/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (strong,nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + (bounds.size.width / 2.0);
    center.y = bounds.origin.y + (bounds.size.height / 2.0);
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:(M_PI * 2.0) clockwise:true];
    }
    path.lineWidth = 10.0;
    [self.circleColor setStroke];
    [path stroke];
}

- (void)drawLogo:(CGPoint)center
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    float imageWidth = logoImage.size.width / 2;
    float imageHeight = logoImage.size.height / 2;
    CGRect logoRect = CGRectMake((center.x - (imageWidth / 2)), (center.y - (imageHeight / 2)), imageWidth, imageHeight);
    
    CGContextSaveGState(currentContext);
    [logoImage drawInRect:logoRect];
    CGContextRestoreGState(currentContext);
}

- (void)drawTriangle:(CGPoint)center bounds:(CGRect)bounds
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGPoint startPoint = CGPointMake(center.x, bounds.size.height / 6);
    CGPoint endPoint = CGPointMake(center.x, bounds.size.height / 6 * 5);
    [trianglePath moveToPoint:startPoint];
    [trianglePath addLineToPoint:CGPointMake(endPoint.x + (bounds.size.width / 3.0), endPoint.y)];
    [trianglePath addLineToPoint:CGPointMake(endPoint.x - (bounds.size.width / 3.0), endPoint.y)];
    [trianglePath closePath];
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGContextSaveGState(currentContext);
    [trianglePath addClip];
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(currentContext);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
}


@end
