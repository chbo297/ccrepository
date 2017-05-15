//
//  ViewController.m
//  TESwiftAOBC
//
//  Created by bo on 09/05/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "TESwiftAOBC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[TESwift new] loglog];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
