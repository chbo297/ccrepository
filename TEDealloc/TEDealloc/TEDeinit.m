//
//  TEDeinit.m
//  TEDealloc
//
//  Created by bo on 23/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "TEDeinit.h"

@implementation TEDeinit

- (void)play {
    NSLog(@"play:%@", [NSThread currentThread]);
}

- (void)dealloc {
    NSLog(@"dealloc:%@", [NSThread currentThread]);
}

@end
