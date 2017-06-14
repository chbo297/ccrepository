//
//  ViewController.m
//  TE2x3xFloatUI
//
//  Created by bo on 10/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "TE2x3xFloatUI-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat beginx = 25;
    CGFloat beginy = 25;
//    CALayer
    for (CGFloat width = 0.1; width < 2.5; width += 0.1) {
        TELabelAndLine *line = [[TELabelAndLine alloc] initWithWidth:width];
        CGRect frame = line.frame;
        frame.origin = CGPointMake(beginx, beginy);
        frame.size = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
        line.frame = frame;
        line.backgroundColor = [UIColor greenColor];
        [self.view addSubview:line];
        
        beginx += 2500;
        
        if (beginx > self.view.bounds.size.width - 20) {
            beginx = 25 + width;
            beginy += 45;
        }
        
        if (beginy >= 900) {
            break;
        }
        
    }
    
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, self.view.bounds.size.height)];
    left.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:left];
    self.view.backgroundColor = [UIColor blackColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
