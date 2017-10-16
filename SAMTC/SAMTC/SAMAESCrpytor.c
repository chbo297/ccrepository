//
//  SAMAESCrpytor.c
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#include "SAMAESCrpytor.h"
#include "SAMCLPre.h"
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonCryptor.h>
#include "SAMCDataTF.h"

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
