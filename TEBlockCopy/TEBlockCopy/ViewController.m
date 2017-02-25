//
//  ViewController.m
//  TEBlockCopy
//
//  Created by bo on 23/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "ViewController.h"
#import "TE2ViewController.h"

@interface TEView : UIView

@end

@implementation TEView

- (BOOL)isFirstResponder {
    BOOL b = [super isFirstResponder];
    NSLog(@"view: %s\n %i", __func__, b);
    return b;
}
    
- (BOOL)becomeFirstResponder {
    BOOL b = [super becomeFirstResponder];
    NSLog(@"view: %s\n %i", __func__, b);
    return b;
}
    
- (UIResponder *)nextResponder {
    UIResponder *b = [super nextResponder];
    NSLog(@"view: %s\n %@", __func__, b);
    return b;
}
    
    - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
        UIView *view = [super hitTest:point withEvent:event];
        NSLog(@"view: %s\n %@", __func__, view);
        return view;
    }
    
    - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        NSLog(@"view: 0001 %s", __func__);
        [super touchesBegan:touches withEvent:event];
        NSLog(@"view: 0002 ");
    }
    
    - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [super touchesMoved:touches withEvent:event];
    }

@end

@interface ViewController ()

    @property (nonatomic, assign) id bl;
    
@end

@implementation ViewController

//- (void)loadView{
//    self.view = [TEView new];
//}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.class aaView];
    [self addChildViewController:[TE2ViewController new]];
    self.view = [TEView new];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self creatBlock];
    
//    void (^block)(void) = self.bl;
    NSString *block = self.bl;
    NSLog(@"2.%@", block);
//    block();
    
}
- (IBAction)bubu:(id)sender {
    [self creatBlock];
}
    
- (IBAction)display:(id)sender {
//    NSString *block = self.bl;
    NSLog(@"2.%@", self.bl);
}


- (void)creatBlock{
//    void (^block)(void) = ^(void){
//        NSLog(@"block run ");
//    };
//    
//    NSLog(@"%@", block);
//    block();
    __weak NSString *block = @"asd";
    NSLog(@"1.%@", block);
    self.bl = block;
    
}

- (BOOL)isFirstResponder {
    BOOL b = [super isFirstResponder];
    NSLog(@"vc: %s\n %i", __func__, b);
    return b;
}

- (BOOL)becomeFirstResponder {
    BOOL b = [super becomeFirstResponder];
    NSLog(@"vc: %s\n %i", __func__, b);
    return b;
}
    
- (UIResponder *)nextResponder {
    UIResponder *b = [super nextResponder];
    NSLog(@"vc: %s\n %@", __func__, b);
    return b;
}


@end
