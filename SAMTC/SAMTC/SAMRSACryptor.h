//
//  SAMRSACryptor.h
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import <Foundation/Foundation.h>

int sam_topRSAEncryptToBase64(const char *buf, size_t buf_length,  char **outdata, size_t *out_length);

int sam_topRSADecryptWithBase64(const char *buf, size_t buf_length, void **outdata, size_t *out_length);

