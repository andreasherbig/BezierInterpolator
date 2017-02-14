//
//  SineMover.m
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 14.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import "SineMover.h"


@implementation SineMover

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.currentValue = 0;
    }
    return self;
}

- (float)deltaMovement:(NSTimeInterval)interval
{
    float delta = self.currentValue;
    
    self.time += interval;
    self.currentValue = self.amplitude * sinf(M_2_PI * self.time/self.frequency);
    
    delta = -(delta - self.currentValue);
    
    return delta;
}

@end
