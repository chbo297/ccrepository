//
//  ViewController.m
//  TEObserveRelease
//
//  Created by bo on 03/07/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "TEO1.h"
#import "TEO2.h"

@interface ViewController ()

@end

@implementation ViewController
{
    TEO1 *_o1;
    TEO2 *_o2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _o1 = [TEO1 new];
    _o2 = [TEO2 new];
    
//    NSNotificationCenter.defaultCenter.a
    [_o2 addObserver:_o1 forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [_o2 addObserver:_o1 forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)do1:(id)sender {
    _o2.name = [NSString stringWithFormat:@"%@ aa", _o2.name];
}
- (IBAction)du2:(id)sender {
    
    _o2 = nil;
    
}

@end
