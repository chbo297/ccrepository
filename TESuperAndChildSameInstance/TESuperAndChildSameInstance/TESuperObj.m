//
//  TESuperObj.m
//  TESuperAndChildSameInstance
//
//  Created by bo on 12/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "TESuperObj.h"

@implementation TESuperObj

- (NSString *)stss
{
    if (!_stss) {
        _stss = @"superstss";
    }
    return _stss;
}

@end
