//
//  ViewController.m
//  TENavigaaBackIcon
//
//  Created by bo on 18/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *redv = [UIView new];
    redv.backgroundColor = [UIColor redColor];
    
    UIView *blurv = [UIView new];
    blurv.backgroundColor = [UIColor blueColor];
    
    UIView *yelv = [UIView new];
    yelv.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:redv];
    [self.view addSubview:blurv];
    [self.view addSubview:yelv];
    
    [redv setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *c1 = [redv.topAnchor constraintEqualToAnchor:self.view.readableContentGuide.bottomAnchor];
    NSLayoutConstraint *c2 = [redv.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *c3 = [redv.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *c4 = [redv.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    [NSLayoutConstraint activateConstraints:@[c1,c2,c3,c4]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    
//    [self.view addConstraints:@[c1,c2,c3,c4]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
