//
//  SAMBase64.h
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#ifndef SAMBase64_h
#define SAMBase64_h

#include <stdio.h>

int sam_base64_encode(unsigned char **dst, int *dlen,
                      const unsigned char *src, int slen);
int sam_base64_decode(unsigned char **dst, int *dlen,
                      const unsigned char *src, int slen);

#endif /* SAMBase64_h */
