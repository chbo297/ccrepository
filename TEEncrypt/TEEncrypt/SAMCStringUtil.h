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

int sam_base64_encode(unsigned char **dst, int *dlen,
                      const unsigned char *src, int slen);
int sam_base64_decode(unsigned char **dst, int *dlen,
                      const unsigned char *src, int slen);
