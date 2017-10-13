//
//  SAMCCryptor.h
//  TEEncrypt
//
//  Created by bo on 12/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#ifndef SAMCCryptor_h
#define SAMCCryptor_h

#include <stdio.h>

char* sam_generateRandom32Char(void);
int sam_topDecryptBase64Buf(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length);
int sam_topEncrypt(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length);

#endif /* SAMCCryptor_h */
