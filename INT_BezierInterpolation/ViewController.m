//
//  ViewController.m
//  INT_BezierInterpolation
//
//  Created by Andreas Herbig on 13.02.17.
//  Copyright © 2017 3spin GmbH & Co. KG. All rights reserved.
//

#import "ViewController.h"
#import "BezierInterpolation.h"

@interface ViewController ()

@property (nonatomic, strong) BezierInterpolation *bezierView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bezierView = [[BezierInterpolation alloc] initWithFrame:CGRectMake(10,10,self.view.frame.size.width-20,self.view.frame.size.height-20)];
    [self.bezierView setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:self.bezierView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(10, 10, 150, 50)];
    [btn setTitle:@"Points" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(togglePoints) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(170, 10, 150, 50)];
    [btn setTitle:@"Tangents" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(toggleTangents) forControlEvents:UIControlEventTouchUpInside];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(330, 10, 200, 50)];
    [slider setMinimumValue:0.0f];
    [slider setMaximumValue:0.5f];
    [slider setContinuous:YES];
    [slider setValue:self.bezierView.smoothLevel];
    [slider addTarget:self action:@selector(changeSmoothLevel:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(540, 10, 150, 50)];
    [btn setTitle:@"Random" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)togglePoints
{
    self.bezierView.showPoints = !self.bezierView.showPoints;
}

- (void)toggleTangents
{
    self.bezierView.showTangents = !self.bezierView.showTangents;
}

- (void)changeSmoothLevel:(UISlider*)slider
{
    self.bezierView.smoothLevel = slider.value;
}

- (void)random
{
    [self.bezierView createWithAmountOfPoints:arc4random_uniform(16) + 4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
