//
//  ViewController.m
//  TEImageResize
//
//  Created by bo on 15/06/2017.
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
    
    self.imagev.image = [[UIImage imageNamed:@"test"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 100, 100, 100) resizingMode:UIImageResizingModeTile];
//    self.imagev.contentMode
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)s1change:(UIStepper *)sender {
    CGRect frame = self.imagev.frame;
    frame.size.width = sender.value;
    self.imagev.frame = frame;
}

- (IBAction)s2change:(UIStepper *)sender {
    CGRect frame = self.imagev.frame;
    frame.size.height = sender.value;
    self.imagev.frame = frame;
}
@end
