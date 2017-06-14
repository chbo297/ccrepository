//
//  ViewController.m
//  TENavigationChildVC
//
//  Created by bo on 08/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = @"title";
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bu:(id)sender {
    UIViewController *vc = [ViewController2 new];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
//    [vc didMoveToParentViewController:self];
}

@end
