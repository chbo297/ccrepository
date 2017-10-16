//
//  SAMCDataTF.c
//  TEEncrypt
//
//  Created by bo on 13/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#include "SAMCDataTF.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

static size_t sam_block_size = 127;
static size_t sam_block_size_min = 7;
static char sam_header = 0x3c;
static char sam_trailing = 0xc3;

int sam_tf_data(void *data, size_t data_length)
{
    if (!data || !data_length) {
        return 0;
    }
    
    unsigned char *handdata = (unsigned char *)data;
    handdata[0] ^= sam_header;
    handdata[data_length-1] ^= sam_trailing;
    
    if (data_length < sam_block_size_min) {
        return 0;
    }
    
    size_t tfsize = (data_length < sam_block_size ? data_length : sam_block_size);
    
    unsigned char *tpbuf = (unsigned char *)malloc(tfsize);
    if (tfsize%2) {
        size_t midnum = (tfsize-1)/2 + 1;
        for (int idx = 1; idx <= tfsize; idx++) {
            if (tfsize == idx) {
                tpbuf[idx-1] = handdata[(idx-1)/2];
            } else if (idx%2) {
                tpbuf[idx-1] = handdata[(idx+1)/2 - 1];
            } else {
                tpbuf[idx-1] = handdata[midnum + idx/2 - 1];
            }
        }
    } else {
        size_t midnum = tfsize/2;
        for (int idx = 1; idx <= tfsize; idx++) {
            if (idx%2) {
                tpbuf[idx-1] = handdata[(idx+1)/2 - 1];
            } else {
                tpbuf[idx-1] = handdata[midnum + idx/2 - 1];
            }
        }
    }
    
    memcpy(handdata, tpbuf, tfsize);
    free(tpbuf);
    return 0;
}


int sam_tf_reverse_data(void *data, size_t data_length)
{
    if (!data || !data_length) {
        return 0;
    }
    
    unsigned char *handdata = (unsigned char *)data;
    
    if (data_length >= sam_block_size_min) {
        size_t tfsize = (data_length < sam_block_size ? data_length : sam_block_size);
        unsigned char *tpbuf = (unsigned char *)malloc(tfsize);
        if (tfsize%2) {
            size_t midnum = (tfsize-1)/2 + 1;
            for (int idx = 1; idx <= tfsize; idx++) {
                if (idx == midnum) {
                    tpbuf[idx-1] = handdata[tfsize-1];
                } else if (idx < midnum) {
                    tpbuf[idx-1] = handdata[2*idx - 1 - 1];
                } else {
                    tpbuf[idx-1] = handdata[(idx-midnum)*2 - 1];
                }
            }
        } else {
            size_t midnum = tfsize/2;
            for (int idx = 1; idx <= tfsize; idx++) {
                if (idx <= midnum) {
                    tpbuf[idx-1] = handdata[2*idx - 1 - 1];
                } else {
                    tpbuf[idx-1] = handdata[(idx-midnum)*2 - 1];
                }
            }
        }
        
        memcpy(handdata, tpbuf, tfsize);
        free(tpbuf);
    }
    
    handdata[0] ^= sam_header;
    handdata[data_length-1] ^= sam_trailing;
    
    return 0;
}
