//
//  ViewController.m
//  TEKvo
//
//  Created by bo on 25/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "ViewController.h"
#import "TECup.h"

@interface ViewController ()

@property (nonatomic, strong) TECup *cup;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cup = [TECup new];
    [self.cup addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [self.cup addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];

    
    
}
- (IBAction)bu1:(id)sender {
    [self.cup setValue:@"name1" forKey:@"name"];
}
- (IBAction)bu2:(id)sender {
    self.cup.age += 100;
    self.cup.name = @"newna";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        
        NSLog(@"name change:\n%@", change);
    } else if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"age change:\n%@", change);
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
