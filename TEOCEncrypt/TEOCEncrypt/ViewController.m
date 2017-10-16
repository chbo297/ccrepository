//
//  ViewController.m
//  TEOCEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "ViewController.h"
#import "SAMTC.h"
//#import "TEStaticLib1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)ddd:(id)sender {
    NSString *str = sam_network_encrypt(@"asd");
//    NSLog(@"%@", str);
    NSString *str2 = sam_network_decrypt(str);
    NSLog(@"%@", str2);
//    [TEStaticLib1 testlib1];
//    te_printTest();
//    NSString *astr = sam_network_decrypt(@"aasda");
//    NSString *bstr = sam_network_decrypt(astr);
//    NSLog(bstr);
//    NSString *astr = sam_network_encrypt(@"abc");
//    NSLog(@"%@", astr);
//    NSString *bstr = sam_network_decrypt(astr);
//    NSLog(@"%@", bstr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
