//
//  SAMRSACryptor.h
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *sam_topRSAEncryptToBase64(const char *buf, size_t buf_length);

extern int sam_topRSADecryptWithBase64(NSString *str, void **outdata, size_t *out_Length);

