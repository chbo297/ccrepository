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

typedef int (*SAM_NTC)(const char *buf, size_t buf_length, char **outdata, size_t *out_Length);

extern SAM_NTC sam_ntc_encrypt;
extern SAM_NTC sam_ntc_dncrypt;

#endif /* SAMTC_h */
