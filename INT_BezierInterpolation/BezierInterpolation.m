//
//  BezierInterpolation.m
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 13.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import "BezierInterpolation.h"
#import "PointWrapper.h"
#import "MathHelper.h"


@interface BezierInterpolation ()

@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) NSMutableArray<PointWrapper*> *points;

@end

@implementation BezierInterpolation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.strokeColor = [UIColor lightGrayColor];
        
        self.showPoints = YES;
        self.showTangents = YES;
        self.smoothLevel = 0.5f;
        
        NSInteger amountOfPoints = 6;
        
        [self createWithAmountOfPoints:amountOfPoints];
        
        [NSTimer scheduledTimerWithTimeInterval:1/60.f target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
        
    }
    return self;
}

- (void)createWithAmountOfPoints:(NSInteger)pointAmount
{
    if(self.points != nil)
    {
        [self.points removeAllObjects];
    }
    
    self.points = [[NSMutableArray alloc] initWithCapacity:pointAmount+1];
    
    
    NSInteger i;
    for(i = 0; i < pointAmount; i++)
    {
        PointWrapper *point = [[PointWrapper alloc] init];
        point.point = CGPointMake([MathHelper randomFloatFrom:10 to:850], [MathHelper randomFloatFrom:100 to:700]);
        [self.points addObject:point];
    }
    
    BOOL closePath = YES;
    if(closePath)
    {
        [self.points addObject:self.points[0]];
    }
    
    for(i = 0; i < self.points.count; i++)
    {
        self.points[i].smoothLevel = self.smoothLevel;
        
        if(i != 0)
        {
            self.points[i].previousPoint = self.points[i-1];
        }
        if(i != self.points.count-1)
        {
            self.points[i].nextPoint = self.points[i+1];
        }
        
        [self.points[i] updateControlPoints:0];
    }
    

}

- (void)updateTime:(NSTimer*)timer
{
    NSInteger i;
    for(i = 0; i < self.points.count; i++)
    {
        self.points[i].smoothLevel = self.smoothLevel;
        [self.points[i] updateControlPoints:[timer timeInterval]];
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    
    CGContextMoveToPoint(context, self.points[0].point.x, self.points[0].point.y);
    
    PointWrapper *currentPoint;
    PointWrapper *nextPoint;
    
    NSInteger i;
    for(i = 0; i < self.points.count-1; i++)
    {
        currentPoint = self.points[i];
        nextPoint = self.points[i+1];
        
        CGContextAddCurveToPoint(context, currentPoint.outgoingControlpoint.x, currentPoint.outgoingControlpoint.y, nextPoint.incomingControlpoint.x, nextPoint.incomingControlpoint.y, nextPoint.point.x, nextPoint.point.y);
    }
    
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    if(self.showTangents)
    {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        for(i = 0; i < self.points.count; i++)
        {
            CGContextMoveToPoint(context, self.points[i].incomingControlpoint.x, self.points[i].incomingControlpoint.y);
            CGContextAddLineToPoint(context, self.points[i].outgoingControlpoint.x, self.points[i].outgoingControlpoint.y);
            CGContextDrawPath(context, kCGPathStroke);
        }
    }
    
    if(self.showPoints)
    {
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        for (PointWrapper* point in self.points) {
            [self drawCrossAtLocation:point.point context:context];
        }
    }
    
}


- (void)drawCrossAtLocation:(CGPoint)location context:(CGContextRef)context
{
    CGContextMoveToPoint(context, location.x-5, location.y-5);
    CGContextAddLineToPoint(context, location.x+5, location.y+5);
    CGContextMoveToPoint(context, location.x-5, location.y+5);
    CGContextAddLineToPoint(context, location.x+5, location.y-5);
    CGContextDrawPath(context, kCGPathStroke);

}


@end
