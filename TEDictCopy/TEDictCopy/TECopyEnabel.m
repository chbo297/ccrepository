//
//  TECopyEnabel.m
//  TEDictCopy
//
//  Created by bo on 15/06/2017.
//  Copyright © 2017 TE. All rights reserved.
//

#import "TECopyEnabel.h"

@implementation TECopyEnabel

- (id)copyWithZone:(NSZone *)zone
{
    TECopyEnabel *t = [TECopyEnabel new];
    t.str = [self.str stringByAppendingString:@"copy"];
    return t;
}

- (id)copy
{
    TECopyEnabel *t = [TECopyEnabel new];
    t.str = [self.str stringByAppendingString:@"copy"];
    return t;
}

@end
