//
//  ViewController.m
//  TECGDraw
//
//  Created by bo on 08/05/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat radius = 5;
    
    
    const CGRect boundingRect = CGRectMake(0, 0, 280, 307);
    
    UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:boundingRect
                                                      byRoundingCorners:UIRectCornerAllCorners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    CGContextFillRect(context, boundingRect);
    
    CGPathRef pathcircle = [[UIBezierPath bezierPathWithArcCenter:CGPointMake(140, 0)
                                                      radius:213
                                                  startAngle:0 endAngle:M_PI
                                                   clockwise:YES] CGPath];
    CGContextAddPath(context, pathcircle);
    CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextFillPath(context);
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImage *outimage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
    
    self.imagev.contentMode = UIViewContentModeScaleAspectFit;
    self.imagev.image = outimage;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
