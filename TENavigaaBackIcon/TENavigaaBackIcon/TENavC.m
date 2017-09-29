//
//  TENavC.m
//  TENavigaaBackIcon
//
//  Created by bo on 18/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "TENavC.h"

@interface TENavC ()

@end

@implementation TENavC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"backi"];
    self.navigationBar.backIndicatorImage = image;
    self.navigationBar.backIndicatorTransitionMaskImage = image;
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
//    // Do any additional setup after loading the view.
//
//    self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"d44"];
//    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"d44"];
//    self.navigationBar.tintColor = [UIColor blackColor];
    
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
