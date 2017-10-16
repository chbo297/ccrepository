//
//  SAMCDataTF.h
//  TEEncrypt
//
//  Created by bo on 13/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#ifndef SAMCDataTF_h
#define SAMCDataTF_h

#include <stdio.h>

int sam_tf_reverse_data(void *data, size_t data_length);
int sam_tf_data(void *data, size_t data_length);

int sam_encodeJoinString(const char *buf1, size_t buf1_length, const char *buf2, size_t buf2_length, char **outdata, size_t *out_length);
int sam_decodeSeparateString(const char *input, size_t input_length,
                             char **buf1, size_t *buf1_length,
                             char **buf2, size_t *buf2_length);

#endif /* SAMCDataTF_h */
