//
//  SAMAESCrpytor.c
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#include "SAMAESCrpytor.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonCryptor.h>
#include "SAMCDataTF.h"
#import "SAMBase64.h"

static int sam_aesEncrypt(const void *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_length)
{
    if (!buf || !buf_length || !key || key_length != 32 || !outdata || !out_length) {
        return -1;
    }
    
    //custom02处理转换aes所需的key
    unsigned char *ukey = malloc(key_length+1);
    memset(ukey, 0, key_length+1);
    for (int i=0; i<key_length; i++) {
        ukey[i] ^= key[i] ^ (int8_t)i;
    }
    
    // setup output buffer
    size_t bufferSize = buf_length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          ukey,     // Key
                                          key_length,    // kCCKeySizeAES
                                          ukey+16,       // IV
                                          buf,
                                          buf_length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    free(ukey);
    
    if (cryptStatus == kCCSuccess) {
        *outdata = buffer;
        *out_length = encryptedSize;
        return 0;
    } else {
        free(buffer);
        return cryptStatus;
    }
}

static int sam_aesDecrypt(const void *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_length)
{
    if (!buf || !buf_length || !key || key_length != 32 || !outdata || !out_length) {
        return -1;
    }
    
    //custom02处理转换aes所需的key
    unsigned char *ukey = malloc(key_length);
    memset(ukey, 0, key_length);
    for (int i=0; i<key_length; i++) {
        ukey[i] ^= key[i] ^ (int8_t)i;
    }
    
    // setup output buffer
    size_t bufferSize = buf_length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          ukey,     // Key
                                          key_length,    // kCCKeySizeAES
                                          ukey+16,       // IV
                                          buf,
                                          buf_length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    free(ukey);
    
    if (cryptStatus == kCCSuccess) {
        *outdata = buffer;
        *out_length = encryptedSize;
        return 0;
    } else {
        free(buffer);
        return cryptStatus;
    }
}

char* sam_generateRandom32Char(void)
{
    int buflength = 32;
    
    char *arcbuf = (char *)malloc(buflength + 1);
    memset(arcbuf, '\0', buflength + 1);
    
    for (int i = 0; i < buflength; i++) {
        char tempc = 0;
        uint32_t arcn = arc4random_uniform(36);
        if (arcn < 10) {
            tempc = arcn + '0';
        } else {
            tempc = arcn - 10 + 'a';
        }
        arcbuf[i] = tempc;
    }
    
    return arcbuf;
}

int sam_topDataEncrypt(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_length)
{
    int res = sam_aesEncrypt(buf, buf_length, key, key_length, outdata, out_length);
    if (0 == res)
    {
        //custom01编码aes加密后的data
        return sam_tf_data(*outdata, *out_length);
    }
    else
    {
        return res;
    }
}

int sam_topDataDecrypt(const void *data, size_t data_length, const char *key, size_t key_length, void **outdata, size_t *out_length)
{
    if (!data || !data_length || !key || !key_length || !outdata || !out_length) {
        return -1;
    }
    
    void *obf = malloc(data_length);
    memcpy(obf, data, data_length);
    //custom01解码data
    int res = sam_tf_reverse_data(obf, data_length);
    if (0 == res) {
        res = sam_aesDecrypt(obf, data_length, key, key_length, outdata, out_length);
    }
    
    free(obf);
    
    return res;
}

static const unsigned char sam_num64_map[64] = "CmVpOwUxqr67uvSTWyXYZ89+DabFst/cdefEPQRg23hiNj4z015klGHIJKABnoLM";

static const unsigned char sam_num64_dec_map[128] =
{
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 23, 0, 0, 0, 30, 48, 49,
    40, 41, 46, 50, 10, 11, 21, 22, 0, 0,
    0, 0, 0, 0, 0, 58, 59, 0, 24, 35,
    27, 53, 54, 55, 56, 57, 62, 63, 44, 4,
    36, 37, 38, 14, 15, 6, 2, 16, 18, 19,
    20, 0, 0, 0, 0, 0, 0, 25, 26, 31,
    32, 33, 34, 39, 42, 43, 45, 51, 52, 1,
    60, 61, 3, 8, 9, 28, 29, 12, 13, 5,
    7, 17, 47, 0, 0, 0, 0, 0,
};

int sam_encodeJoinString(const char *buf1, size_t buf1_length, const char *buf2, size_t buf2_length, char **outdata, size_t *out_length)
{
    if (!buf1 || !buf1_length || !buf2 || !buf2_length || !outdata || !out_length) {
        return -1;
    }
    
    //计数第一个字符串末尾有几个'='
    int dc1 = 0;
    for (size_t idx = buf1_length-1; idx > 0; idx--) {
        if (buf1[idx] != '=') {
            dc1 = (int)(buf1_length-1-idx);
            break;
        }
    }
    //计数第二个字符串末尾有几个'='
    int dc2 = 0;
    for (size_t idx = buf2_length-1; idx > 0; idx--) {
        if (buf2[idx] != '=') {
            dc2 = (int)(buf2_length-1-idx);
            break;
        }
    }
    
    //计数第二个字符串替换'='字符后有多长
    int sizemap[] = {1, 0, -1};
    size_t b2length = buf2_length + sizemap[dc2];
    *out_length = 2 + buf1_length + sizemap[dc1] + b2length;
    
    //把第二个字符串替换'='后的长度用64进制两位下列字符串表示
    char b2lengthidicator[2];
    const unsigned  char *b2idmap = sam_num64_map;
    b2lengthidicator[0] = b2idmap[b2length/64];
    b2lengthidicator[1] = b2idmap[b2length%64];
    
    //拼接： <表示长度的两位64进制字符> + <替换'='后的字符串1> + <替换'='后的字符串2>
    char *retbuf = (char *)malloc(*out_length + 1);
    memset(retbuf, 0, *out_length + 1);
    const char eqsmap[] = {'s', 'A', 'M'};
    size_t writeidx = 0;
    memcpy(retbuf, b2lengthidicator, 2);
    writeidx += 2;
    memcpy(retbuf+writeidx, &eqsmap[dc1], 1);
    writeidx += 1;
    memcpy(retbuf+writeidx, buf1, buf1_length-dc1);
    writeidx += buf1_length-dc1;
    memcpy(retbuf+writeidx, &eqsmap[dc2], 1);
    writeidx += 1;
    memcpy(retbuf+writeidx, buf2, buf2_length-dc2);
    
    *outdata = retbuf;
    return 0;
}

int sam_decodeSeparateString(const char *input, size_t input_length,
                             char **buf1, size_t *buf1_length,
                             char **buf2, size_t *buf2_length)
{
    if (!buf1 || !buf1_length || !buf2 || !buf2_length || !input || !input_length) {
        return -1;
    }
    
    const unsigned char *b2idmap = sam_num64_dec_map;
    int thecount = b2idmap[input[0]] * 64 + b2idmap[input[1]];
    size_t headerlength = input_length-thecount;
    char b1c = input[2];
    char b2c = input[headerlength];
    const int eqsrmap[] = {
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 1, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 2, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 0, 199, 199, 199, 199,
        199, 199, 199, 199, 199, 199, 199, 199,
    };
    int b1dc = eqsrmap[b1c];
    int b2dc = eqsrmap[b2c];
    if ( 199 == (int)b1dc || 199 == (int)b2dc) {
        return -1;
    }
    
    
    char *ct1 = (char *)malloc(headerlength);
    memset(ct1, 0, headerlength);
    memcpy(ct1, input+2+1, headerlength-2-1);
    memset(ct1+headerlength-2-1, '=', b1dc);
    char *ct2 = (char *)malloc(thecount + 2);
    memset(ct2, 0, thecount + 2);
    memcpy(ct2, input+headerlength+1, thecount-1);
    memset(ct2+thecount-1, '=', b2dc);
    
    *buf1 = ct1;
    *buf2 = ct2;
    *buf1_length = headerlength-2-1 + b1dc;
    *buf2_length = thecount-1 + b2dc;
    
    return 0;
}
