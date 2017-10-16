//
//  ViewController.m
//  SAMEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "ViewController.h"
#import "SAMTC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)ds:(id)sender {
    NSString *s1 = sam_network_encrypt(@"sdf");
    NSString *s2 = sam_network_decrypt(s1);
    NSLog(@"%@", s2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
