//
//  TE2ViewController.m
//  TEBlockCopy
//
//  Created by bo on 23/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "TE2ViewController.h"

@interface TE2ViewController ()

@end

@implementation TE2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UITextField new] resignFirstResponder]
    [self.class aaView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isFirstResponder {
    BOOL b = [super isFirstResponder];
    NSLog(@"vc2: %s\n %i", __func__, b);
    return b;
}
    
- (BOOL)becomeFirstResponder {
    BOOL b = [super becomeFirstResponder];
    NSLog(@"vc2: %s\n %i", __func__, b);
    return b;
}
    
- (UIResponder *)nextResponder {
    UIResponder *b = [super nextResponder];
    NSLog(@"vc2: %s\n %@", __func__, b);
    return b;
}

@end
