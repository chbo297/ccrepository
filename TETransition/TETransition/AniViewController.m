//
//  AniViewController.m
//  TETransition
//
//  Created by bo on 09/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "AniViewController.h"

@interface AniViewController ()
@property (weak, nonatomic) IBOutlet UIView *v2;

@property (strong, nonatomic) UIViewPropertyAnimator *animator;

@end

@implementation AniViewController
{
    char *strr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.v2.layer.cornerRadius = 30;
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:3
                                                               curve:UIViewAnimationCurveLinear
                                                          animations:^{
                                                              self.v2.center = CGPointMake(CGRectGetMaxX(self.view.bounds), self.v2.center.y);
                                                          }];
}
- (IBAction)b1:(UIButton *)sender {
    NSString *curstr = sender.currentTitle;
    if ([curstr isEqualToString:@"b1"]) {
        [self.animator startAnimation];
    } else if ([curstr isEqualToString:@"b2"]) {
        [self.animator stopAnimation:YES];
    } else if ([curstr isEqualToString:@"b3"]) {
        [self.animator stopAnimation:NO];
    } else if ([curstr isEqualToString:@"b4"]) {
        [self.animator pauseAnimation];
    } else if ([curstr isEqualToString:@"b5"]) {
        
    } else if ([curstr isEqualToString:@"b6"]) {
        
    } else if ([curstr isEqualToString:@"b7"]) {
        printf("%s", strr);
    } else if ([curstr isEqualToString:@"b8"]) {
        strr = [@"abc" dataUsingEncoding:NSUTF8StringEncoding].bytes;
        printf("%s", strr);
    } else if ([curstr isEqualToString:@"b9"]) {
        
    }
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
