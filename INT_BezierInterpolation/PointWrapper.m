//
//  PointWrapper.m
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 13.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import "PointWrapper.h"
#import "SineMover.h"
#import "MathHelper.h"

@interface PointWrapper ()

@property (nonatomic, strong) SineMover *xMover;
@property (nonatomic, strong) SineMover *yMover;

@end

@implementation PointWrapper

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.xMover = [[SineMover alloc] init];
        self.xMover.frequency = [MathHelper randomFloatFrom:0.5f to:3.5f];
        self.xMover.time = [MathHelper randomFloatFrom:0.f to:self.xMover.frequency];
        self.xMover.amplitude =  [MathHelper randomFloatFrom:30 to:200];
        
        self.yMover = [[SineMover alloc] init];
        self.yMover.frequency = [MathHelper randomFloatFrom:0.5f to:3.5f];
        self.yMover.time = [MathHelper randomFloatFrom:0.f to:self.yMover.frequency];
        self.yMover.amplitude =  [MathHelper randomFloatFrom:30.f to:200.f];
        
        _incomingControlpoint = CGPointZero;
        _outgoingControlpoint = CGPointZero;
    }
    return self;
}


- (void)updateControlPoints:(NSTimeInterval)interval
{
    float deltaX = [self.xMover deltaMovement:interval];
    float deltaY = [self.yMover deltaMovement:interval];
    
    self.point = CGPointMake(self.point.x + deltaX, self.point.y + deltaY);
    
    if(self.previousPoint == nil || self.nextPoint == nil)
    {
        // TODO: could check if last point is equal to first point to calculate perfect loop.... at the moment, we skip them...
        _incomingControlpoint = self.point;
        _outgoingControlpoint = self.point;
        return;
    }
    
    CGPoint vectorTangent = CGPointMake(self.nextPoint.point.x - self.previousPoint.point.x, self.nextPoint.point.y - self.previousPoint.point.y);
    vectorTangent = [self convertToEinheitsVector:vectorTangent];
    
    
    float length_prev_to_current = [self vectorLengthForVector:CGPointMake(self.point.x-self.previousPoint.point.x, self.point.y-self.previousPoint.point.y)];
    float scaleFactorPrevToCurrent = length_prev_to_current * self.smoothLevel;
    
    _incomingControlpoint = CGPointMake(self.point.x - (vectorTangent.x * scaleFactorPrevToCurrent), self.point.y - (vectorTangent.y * scaleFactorPrevToCurrent));
    
    
    float length_current_to_next = [self vectorLengthForVector:CGPointMake(self.nextPoint.point.x - self.point.x, self.nextPoint.point.y - self.point.y)];
    float scaleFactorCurrentToNext = length_current_to_next * self.smoothLevel;
    
    _outgoingControlpoint = CGPointMake(self.point.x + (vectorTangent.x * scaleFactorCurrentToNext), self.point.y + (vectorTangent.y * scaleFactorCurrentToNext));
    
}


- (float)vectorLengthForVector:(CGPoint)vector
{
    return sqrt(pow(vector.x, 2) + pow(vector.y, 2));
}

- (CGPoint)convertToEinheitsVector:(CGPoint)vector
{
    float vectorLength = [self vectorLengthForVector:vector];
    
    return CGPointMake(vector.x / vectorLength, vector.y / vectorLength);
}

@end
