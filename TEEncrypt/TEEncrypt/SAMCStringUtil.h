//
//  SAMCStringUtil.h
//  TEEncrypt
//
//  Created by bo on 15/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *sam_base64StringWithdata(NSData *data);

extern NSData *sam_dataWithBase64String(NSString *str);
