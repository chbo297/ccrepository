//
//  NSObject+TENono.h
//  TERuntimeDestruct
//
//  Created by bo on 04/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DLIntrospection)

+ (NSArray *)classes;
+ (NSArray *)properties;
+ (NSArray *)instanceVariables;
+ (NSArray *)classMethods;
+ (NSArray *)instanceMethods;

+ (NSArray *)protocols;
+ (NSDictionary *)descriptionForProtocol:(Protocol *)proto;


+ (NSString *)parentClassHierarchy;

@end
