//
//  GPUView.m
//  TestGPU_View
//
//  Created by rex on 2019/8/18.
//  Copyright © 2019 rex. All rights reserved.
//

#import "GPUView.h"
#import <CoreGraphics/CoreGraphics.h>

#define DRAW_GPU

@interface GPUView()
{
    NSMutableArray *lines;
}
@end

@implementation GPUView
- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor purpleColor];
    return self;
}

- (void)prepareRender
{
    lines = [NSMutableArray new];
    [lines addObject:[NSNumber valueWithCGPoint:CGPointMake(0, 110)]];
    [lines addObject:[NSNumber valueWithCGPoint:CGPointMake(120, 130)]];
    [lines addObject:[NSNumber valueWithCGPoint:CGPointMake(210, 420)]];
    for (int i = 0; i < 1000; i++)
    {
        [lines addObject:[NSNumber valueWithCGPoint:CGPointMake(rand()%320, rand()%950)]];
    }
    
    drawingLayer = [[CAShapeLayer alloc] init];
    [self.layer addSublayer:drawingLayer];
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTextColor
{
    NSLog(@"updateTextColor..");
    [self.layer setNeedsDisplay];
}

#ifdef DRAW_GPU
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    UIBezierPath *bpath = [[UIBezierPath alloc] init];
    // loop through every element (static typing)
    int c = 0;
    for (NSNumber *num in lines) {
        if (c == 0) {
            [bpath moveToPoint:[num CGPointValue]];
            c++;
        }
        else
        {
            [bpath addLineToPoint:[num CGPointValue]];
        }
    }
    drawingLayer.opacity = 1;
    drawingLayer.path = bpath.CGPath;
    drawingLayer.lineCap = kCALineCapRound;
    drawingLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    drawingLayer.lineWidth = 1.2;
    drawingLayer.fillColor = [UIColor clearColor].CGColor;
}

#else
- (void)drawRect:(CGRect)rect
{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);
    
    CGPoint start = [[lines firstObject] CGPointValue];
    CGContextMoveToPoint(context, start.x, start.y);
    
    CGPoint addLines[lines.count-1];
    for (int j = 1; j < [lines count]; j++)
    {
        CGPoint point = [[lines objectAtIndex:j] CGPointValue];
        addLines[j].x = point.x;
        addLines[j].y = point.y;
    }
    
    CGContextAddLines(context, addLines, lines.count-1);
    CGContextStrokePath(context);
}
#endif
@end
