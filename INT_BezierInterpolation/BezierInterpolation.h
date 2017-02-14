//
//  BezierInterpolation.h
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 13.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BezierInterpolation : UIView

@property (nonatomic) BOOL showPoints;
@property (nonatomic) BOOL showTangents;
@property (nonatomic) CGFloat smoothLevel;

- (void)createWithAmountOfPoints:(NSInteger)pointAmount;

@end
