//
//  ViewController.m
//  TEOCSwift
//
//  Created by bo on 22/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "ViewController.h"
#import "TEOCSwift-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[TECCString new] ccPrint];
//    TECCS
}

- (void)ocPrint {
    NSLog(@"swift use oc ococ print");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
