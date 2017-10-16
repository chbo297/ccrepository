//
//  TEStaticLib1.m
//  TEStaticLib1
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "TEStaticLib1.h"

NSString * te_printTest()
{
    printf("NSString * te_printTest()\n");
    return @"te_printTest";
}

@implementation TEStaticLib1

+ (void)testlib1
{
    NSLog(@"testlib1");
}

@end
