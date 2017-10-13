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

static size_t sam_block_size = 9;
static char sam_header = 0x3c;
static char sam_trailing = 0xc3;

int sam_tf_data(void *data, size_t data_length)
{
    unsigned char *handdata = (unsigned char *)data;
    handdata[0] ^= sam_header;
    handdata[data_length-1] ^= sam_trailing;
    
    size_t blocksize = sam_block_size;
    
    if (data_length < blocksize) {
        return 0;
    }
    
    size_t count = data_length/blocksize;
    
    unsigned char *tpbuf = (unsigned char *)malloc(blocksize);
    
    for (size_t i = 0; i < count; i++) {
        unsigned char *blockdata = &handdata[i*blocksize];
        for (int m = 1; m <= blocksize; m++) {
            
            if (blocksize == m) {
                tpbuf[m-1] = blockdata[(m-1)/2];
            } else if (m%2) {
                tpbuf[m-1] = blockdata[(m+1)/2 - 1];
            } else {
                tpbuf[m-1] = blockdata[(blocksize-1)/2 + 1 + m/2 - 1];
            }
        }
        memcpy(blockdata, tpbuf, blocksize);
    }
    
    return 0;
}


int sam_tf_reverse_data(void *data, size_t data_length)
{
    char *handdata = (char *)data;
    size_t blocksize = sam_block_size;
    if (data_length > blocksize) {
        size_t count = data_length/blocksize;
        
        char *tpbuf = (char *)malloc(blocksize);
        size_t midblk = (blocksize-1)/2 + 1;
        
        for (size_t i = 0; i < count; i++) {
            char *blockdata = &handdata[i*blocksize];
            for (int m = 1; m <= blocksize; m++) {
                if (midblk == m) {
                    tpbuf[m-1] = blockdata[blocksize-1];
                } else if (m < midblk) {
                    tpbuf[m-1] = blockdata[2*m - 1 - 1];
                } else {
                    tpbuf[m-1] = blockdata[(m-midblk)*2 - 1];
                }
            }
            memcpy(blockdata, tpbuf, blocksize);
        }
    }
    
    handdata[0] ^= sam_header;
    handdata[data_length-1] ^= sam_trailing;
    
    return 0;
}
