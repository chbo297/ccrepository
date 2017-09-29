//
//  TEO2.m
//  TEObserveRelease
//
//  Created by bo on 03/07/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "TEO2.h"
#import <objc/runtime.h>

@implementation TEO2

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

@interface NSNotificationCenter (cdealloc)

@end

@implementation NSNotificationCenter (cdealloc)

+ (void)load
{
    Method m1 = class_getInstanceMethod(self, @selector(c_dealloc));
    Method m2 = class_getInstanceMethod(self, @selector(dealloc));
    
    IMP cdealloc =
    
    method_exchangeImplementations(<#Method m1#>, <#Method m2#>)
}

- (void)removeObserver:(id)observer
{
    
}

@end
