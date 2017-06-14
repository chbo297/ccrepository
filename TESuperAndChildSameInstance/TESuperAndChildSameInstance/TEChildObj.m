//
//  TEChildObj.m
//  TESuperAndChildSameInstance
//
//  Created by bo on 12/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "TEChildObj.h"

@implementation TEChildObj
{
    NSString *_stss;
}

-(NSString *)stss
{
    if (!_stss) {
        _stss = @"child";
    }
    return _stss;
}

- (void)doSome
{
    
}


@end
