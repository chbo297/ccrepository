//
//  AXRequest.h
//  TEEncrypt
//
//  Created by bo on 10/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXRequest : NSObject

+ (void)cryptHost:(NSString *)host
             path:(NSString *)path
           method:(NSString *)method
           params:(NSDictionary *)params
       completion:(void (^)(id respondObj))completion
          failure:(void (^)(NSError *error))failure;

@end
