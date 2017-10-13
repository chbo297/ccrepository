//
//  SAMCCryptor.c
//  TEEncrypt
//
//  Created by bo on 12/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#include "SAMCCryptor.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonCryptor.h>
#include "SAMCDataTF.h"
#include "SAMOCEncryptUtil.h"

static int sam_generateDataWithBase64String(const char *str, size_t str_length, void **out_buf, size_t *out_length)
{
    if (!str || !str_length || !out_buf || !out_length) {
        return -1;
    }
    
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    bool flignore, flendtext = false;
    const unsigned char *tempcstring;
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)str;
    
    lentext = str_length;
    
    char *thebuf = (char *)malloc(lentext);
    unsigned long theindex = 0;
    
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            bool flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                }
                else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    memcpy(&thebuf[theindex], &outbuf[i], 1);
                    theindex += 1;
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    *out_buf = thebuf;
    *out_length = theindex;
    return 0;
}

static int sam_aesEncrypt(const void *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length)
{
    if (!buf || !buf_length || !key || key_length != 32 || !outdata || !out_Length) {
        return -1;
    }
    
    //custom02处理转换aes所需的key
    unsigned char *truekey = malloc(key_length+1);
    memset(truekey, 0, key_length+1);
    for (int i=0; i<key_length; i++) {
        truekey[i] ^= key[i] ^ (int8_t)i;
    }
    
    // setup output buffer
    size_t bufferSize = buf_length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          truekey,     // Key
                                          key_length,    // kCCKeySizeAES
                                          truekey+16,       // IV
                                          buf,
                                          buf_length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    free(truekey);
    
    if (cryptStatus == kCCSuccess) {
        *outdata = buffer;
        *out_Length = encryptedSize;
        return 0;
    } else {
        free(buffer);
        return cryptStatus;
    }
}

static int sam_aesDecrypt(const void *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length)
{
    if (!buf || !buf_length || !key || key_length != 32 || !outdata || !out_Length) {
        return -1;
    }
    
    //custom02处理转换aes所需的key
    unsigned char *truekey = malloc(key_length+1);
    memset(truekey, 0, key_length+1);
    for (int i=0; i<key_length; i++) {
        truekey[i] ^= key[i] ^ (int8_t)i;
    }
    
    // setup output buffer
    size_t bufferSize = buf_length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          truekey,     // Key
                                          key_length,    // kCCKeySizeAES
                                          truekey+16,       // IV
                                          buf,
                                          buf_length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    free(truekey);
    
    if (cryptStatus == kCCSuccess) {
        *outdata = buffer;
        *out_Length = encryptedSize;
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

int sam_topEncrypt(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length)
{
    int res = sam_aesEncrypt(buf, buf_length, key, key_length, outdata, out_Length);
    if (0 == res)
    {
        //test
        return 0;
        //custom01编码aes加密后的data
        return sam_tf_data(*outdata, *out_Length);
    }
    else
    {
        return res;
    }
}

int sam_topDecryptBase64Buf(const char *buf, size_t buf_length, const char *key, size_t key_length, void **outdata, size_t *out_Length)
{
    void *obf;
    size_t ol = 0;
    int res = sam_generateDataWithBase64String(buf, buf_length, &obf, &ol);
    if (0 == res) {
        //custom01解码data
//        res = sam_tf_reverse_data(obf, ol);
        if (0 == res) {
            res = sam_aesDecrypt(obf, ol, key, key_length, outdata, out_Length);
        }
    }
    
    if (obf) {
        free(obf);
    }
    
    return res;
}

__attribute__((constructor))
static void pins_encrypt_link() {
    
}
