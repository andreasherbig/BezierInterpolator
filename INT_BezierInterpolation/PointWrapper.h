//
//  PointWrapper.h
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 13.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointWrapper : NSObject

@property (nonatomic, readonly) CGPoint incomingControlpoint;
@property (nonatomic) CGPoint point;
@property (nonatomic, readonly) CGPoint outgoingControlpoint;
@property (nonatomic) CGFloat smoothLevel;

@property (nonatomic, assign) PointWrapper *previousPoint;
@property (nonatomic, assign) PointWrapper *nextPoint;


- (void)updateControlPoints:(NSTimeInterval)interval;
@end
