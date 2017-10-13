//
//  ViewController.m
//  TEEncrypt
//
//  Created by bo on 10/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "ViewController.h"
#import "AXRequest.h"
#import "ECPTC.h"
#import "test.h"

//extern void mmac2();

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    mmac2();
}
- (IBAction)bb:(id)sender {
    [AXRequest cryptHost:nil path:nil method:nil params:nil completion:^(id respondObj) {
        NSLog(@"%@", respondObj);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (IBAction)es:(id)sender {
    NSLog(@"%@", EncryptWithString(@"a")) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
