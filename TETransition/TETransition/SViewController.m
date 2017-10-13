//
//  SViewController.m
//  TETransition
//
//  Created by bo on 29/09/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SViewController.h"

@interface SViewController ()



@property (weak, nonatomic) IBOutlet UIView *vvb;
@end

@implementation SViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIViewPropertyAnimator
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sd:(id)sender {
    NSLog(@"%@", self.vvb);
//    self.vvb.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
    
    self.vvb.transform = CGAffineTransformTranslate(self.vvb.transform, 1, 1);
    NSLog(@"%@", self.vvb);
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
