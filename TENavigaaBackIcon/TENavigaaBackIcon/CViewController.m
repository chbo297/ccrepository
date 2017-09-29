//
//  CViewController.m
//  TENavigaaBackIcon
//
//  Created by bo on 21/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *i1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backi"] style:UIBarButtonItemStylePlain
                                                          target:nil action:nil];
    UIBarButtonItem *i2 = [[UIBarButtonItem alloc] initWithTitle:@"jkjk" style:UIBarButtonItemStylePlain target:nil
action:nil];
//    self.navigationItem.leftBarButtonItems = @[i1,i2];
//    self.navigationItem.leftItemsSupplementBackButton = NO;
    // Do any additional setup after loading the view.
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
