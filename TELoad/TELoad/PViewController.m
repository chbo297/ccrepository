//
//  PViewController.m
//  TELoad
//
//  Created by bo on 28/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "PViewController.h"
#import "LDObject.h"
#import <objc/objc.h>
#import <OpenGLES/EAGL.h>
#import <GLKit/GLKit.h>
//#import <objc/objc.h>

@interface PViewController ()

@end

@implementation PViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ul", [[NSNull null] hash]);
    // Do any additional setup after loading the view.
    LDObject *l1 = [LDObject new];
    NSLog(@"new%ld", [[l1 classForCoder] hash]);
    LDObject *l2 = [LDObject new];
    NSLog(@"new%ld", [[l2 classForCoder] hash]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
