//
//  SAMAESCrpytor.h
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#ifndef SAMAESCrpytor_h
#define SAMAESCrpytor_h

#include <stdio.h>

char* sam_generateRandom32Char(void);

int sam_topDataEncrypt(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_length);
int sam_topDataDecrypt(const void *data, size_t data_length, const char *key, size_t key_length, void **outdata, size_t *out_length);

int sam_encodeJoinString(const char *buf1, size_t buf1_length, const char *buf2, size_t buf2_length, char **outdata, size_t *out_length);
int sam_decodeSeparateString(const char *input, size_t input_length,
                             char **buf1, size_t *buf1_length,
                             char **buf2, size_t *buf2_length);

#endif /* SAMAESCrpytor_h */
