//
//  ViewController.m
//  TEDealloc
//
//  Created by bo on 23/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import "TEDeinit.h"

@interface ViewController ()

@end

@implementation ViewController
{
    TEDeinit *_ddd;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TEDeinit *dede = [TEDeinit new];
    _ddd = dede;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [dede play];
    });
    
//    [dede play];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_ddd play];
        _ddd = nil;
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
