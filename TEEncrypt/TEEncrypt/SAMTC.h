//
//  SAMTC.h
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#ifndef SAMTC_h
#define SAMTC_h

#include <stdio.h>

extern int sam_ntc_encrypt(const char *buf, size_t buf_length, char **outdata, size_t *out_Length);
extern int sam_ntc_dncrypt(const char *buf, size_t buf_length, char **outdata, size_t *out_Length);

#endif /* SAMTC_h */
