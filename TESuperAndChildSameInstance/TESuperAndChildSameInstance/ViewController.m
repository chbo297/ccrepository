//
//  ViewController.m
//  TESuperAndChildSameInstance
//
//  Created by bo on 12/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "ViewController.h"
#import "TEChildObj.h"
@interface ViewController ()

@end

@implementation ViewController
{
    TEChildObj *_objj;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _objj = [TEChildObj new];
    NSLog(@"%@", _objj.stss);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)do:(id)sender {
    
    [_objj doSome];
}

@end
