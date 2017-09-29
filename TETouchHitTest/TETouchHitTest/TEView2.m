//
//  TEView2.m
//  TETouchHitTest
//
//  Created by bo on 24/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "TEView2.h"

@implementation TEView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    return [super pointInside:point withEvent:event];
}

@end
