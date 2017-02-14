//
//  MathHelper.m
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 14.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import "MathHelper.h"
#define ARC4RANDOM_MAX 0x100000000


@implementation MathHelper

+ (float)randomFloatFrom:(float)fromFloat to:(float)toFloat
{
    return fromFloat + ((toFloat-fromFloat) * ((double)arc4random() / ARC4RANDOM_MAX));
}

@end
