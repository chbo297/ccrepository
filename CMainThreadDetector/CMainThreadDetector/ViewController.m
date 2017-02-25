//
//  ViewController.m
//  CMainThreadDetector
//
//  Created by bo on 25/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import "CMainThreadDetector.h"

@interface ViewController () <CMainThreadDetectorDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [CMainThreadDetector sharedDetector].delegate = self;
    [[CMainThreadDetector sharedDetector] startDetecting];
}

- (void)mainThreadSlowDetectDump:(NSArray<NSString *> *)stackSymbols {
    self.textView.text = stackSymbols.description;
}
- (IBAction)bubu:(id)sender {
    NSMutableString *str = [NSMutableString new];
    
    for (int o = 0; o < 25; o++) {
        for (int i = 0; i < 100; i ++) {
            for (int j = 0; j < 10000; j++) {
                [str appendString:@"hah"];
                [str deleteCharactersInRange:NSMakeRange(str.length-3, 3)];
            }
            
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
