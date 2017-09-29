//
//  RedViewController.m
//  TEPresent
//
//  Created by bo on 16/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "RedViewController.h"
#import "ViewControllerblue.h"


@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(122, 100, 100, 100)];
    but.backgroundColor = [UIColor grayColor];
    [but addTarget:self action:@selector(bubu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)bubu
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    UIViewController *vc = [ViewControllerblue new];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self.presentingViewController presentViewController:vc animated:YES completion:nil];
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
