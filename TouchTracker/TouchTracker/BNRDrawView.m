//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Kevin Lin on 5/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRCircle.h"

@interface BNRDrawView ()

@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) BNRCircle *currentCircle;

@property (nonatomic, strong) UITouch *touch1;
@property (nonatomic, strong) UITouch *touch2;

@property (nonatomic, strong) NSMutableArray *finishedShapes;

@end

@implementation BNRDrawView

# pragma mark - initializers

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self) {
        self.finishedShapes = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

# pragma mark - view drawing

- (void)drawRect:(CGRect)rect
{
    for (NSObject *shape in self.finishedShapes) {
        if ([shape isKindOfClass:[BNRLine class]]) {
            BNRLine *line = (BNRLine *)shape;
            
            [[self colorFromAngle: [line angleInRadians]] set];
            [self strokeLine:line];
        } else {
            BNRCircle *circle = (BNRCircle *)shape;
            [UIColor blackColor];
            
            [[self colorFromAngle:circle.angleInRadians] set];
            [self strokeCircle:circle];
        }
    }
    
    if (self.currentLine) {
        [[self colorFromAngle: [self.currentLine angleInRadians]] set];
        [self strokeLine:self.currentLine];
    }
    
    if (self.currentCircle) {
        [[self colorFromAngle:self.currentCircle.angleInRadians] set];
        [self strokeCircle:self.currentCircle];
    }
}

# pragma mark - view events

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *) event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        if (!self.currentLine && !self.currentCircle) {
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
            self.currentLine = line;
            self.touch1 = t;
        } else if (self.currentLine && !self.currentCircle) {
            self.touch2 = t;
            self.currentLine = nil;
            BNRCircle *circle = [[BNRCircle alloc] init];
            [circle setFromFirstPoint:[self.touch1 locationInView:self] secondPoint:location];
            self.currentCircle = circle;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        if (self.currentLine) {
            if (t == self.touch1) {
                self.currentLine.end = location;
            }
        } else if (self.currentCircle) {
            if (t == self.touch1) {
                [self.currentCircle setFromFirstPoint:location secondPoint:[self.touch2 locationInView:self]];
            } else if (t== self.touch2) {
                [self.currentCircle setFromFirstPoint:[self.touch1 locationInView:self] secondPoint:location];
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        if (self.currentLine) {
            [self.finishedShapes addObject:self.currentLine];
            self.currentLine = nil;
            self.touch1 = nil;
        } else if (self.currentCircle) {
            if (t == self.touch1 || self.touch2) {
                [self.finishedShapes addObject:self.currentCircle];
                self.currentCircle = nil;
                self.touch1 = nil;
                self.touch2 = nil;
            }
        }
    }
    
    NSLog(@"%i", touches.count);
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.touch1 = nil;
    self.touch2 = nil;
    self.currentLine = nil;
    self.currentCircle = nil;
    
    [self setNeedsDisplay];
}

# pragma mark - helpers

- (void)strokeLine: (BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)strokeCircle: (BNRCircle *)circle
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    
    [bp moveToPoint:CGPointMake(circle.center.x + circle.radius, circle.center.y)];
    [bp addArcWithCenter:circle.center radius:circle.radius startAngle:0.0 endAngle:(M_PI * 2.0) clockwise:true];

    [bp stroke];
}

- (UIColor *)colorFromAngle:(CGFloat)radians
{
    CGFloat hue = (radians + M_PI) / (2.0 * M_PI);
    UIColor *lineColor = [[UIColor alloc] initWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
    
    return lineColor;
}


@end
