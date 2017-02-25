//
//  ViewController.m
//  CRunLoopDetector
//
//  Created by bo on 24/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import "CRunLoopDetector.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[CRunLoopDetector sharedRunLoopDetector] startDetecting];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification) name:@"aaa" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification) name:@"aaa" object:nil];[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification) name:@"aaa" object:nil];
}

- (void)receiveNotification {
    NSLog(@"%s", __func__);
}

- (IBAction)bubu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aaa" object:nil];
//    NSMutableString *str = [NSMutableString new];
//    
//    for (int o = 0; o < 5; o++) {
//        for (int i = 0; i < 100; i ++) {
//            for (int j = 0; j < 10000; j++) {
//                [str appendString:@"hah"];
//            }
//            
//        }
//    }
    
}

@end
