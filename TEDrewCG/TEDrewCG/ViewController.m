//
//  ViewController.m
//  TEDrewCG
//
//  Created by bo on 20/04/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imagev.image = [self imageWith:[UIImage imageNamed:@"moonBg"]] ;
}

- (UIImage *)imageWith:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                      byRoundingCorners:UIRectCornerAllCorners
                                                            cornerRadii:CGSizeMake(10, 10)];
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGContextDrawImage(context, rect, [image CGImage]);
//    [self.layer renderInContext:context];
    
    UIImage* const imagecor = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imagecor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
