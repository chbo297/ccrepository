//
//  ViewController.m
//  TEDictCopy
//
//  Created by bo on 15/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "TECopyEnabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TECopyEnabel *t1 = [TECopyEnabel new];
    t1.str = @"haha";
    NSDictionary<NSString *, TECopyEnabel *> *dic1 = @{@"key1" : t1};
    
    NSMutableDictionary<NSString *, TECopyEnabel *> *mudic = [NSMutableDictionary new];
    [mudic addEntriesFromDictionary:dic1];
//    [mudic setDictionary:dic1];
    
    
    NSLog(@"%@", [dic1 objectForKey:@"key1"].str);
    NSLog(@"%@", [mudic objectForKey:@"key1"].str);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
