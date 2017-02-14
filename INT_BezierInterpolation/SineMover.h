//
//  SineMover.h
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 14.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SineMover : NSObject

@property (nonatomic) CGFloat time;
@property (nonatomic) CGFloat currentValue;
@property (nonatomic) CGFloat frequency;
@property (nonatomic) CGFloat amplitude;

- (float)deltaMovement:(NSTimeInterval)interval;

@end
