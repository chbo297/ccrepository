//
//  SAMTC.m
//  TEOCEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SAMTC.h"
#import "SAMAESCrpytor.h"
#import "SAMRSACryptor.h"
#import "SAMCDataTF.h"
#import "SAMBase64.h"

__attribute__((__always_inline__))
static int __encryptor(const char *buf, size_t buf_length, char **outdata, size_t *out_length)
{
    if (!buf || !buf_length || !outdata || !out_length) {
        return -1;
    }
    
    char *r32 = sam_generateRandom32Char();
    size_t keylength = 32;
    
    void *rec;
    size_t recsize = 0;
    int suc = sam_topDataEncrypt(buf, buf_length, r32, keylength, &rec, &recsize);
    if (suc != 0) {
        return -1;
    }
    
    unsigned char *tranbase64;
    int tranbase64length;
    suc = sam_base64_encode(&tranbase64, &tranbase64length, rec, (int)recsize);
    free(rec);
    if (0 != suc) {
        return -1;
    }
    char *keybase64;
    size_t keybase64length = 0;
    suc = sam_topRSAEncryptToBase64(r32, keylength, &keybase64, &keybase64length);
    free(r32);
    if (0 != suc) {
        return -1;
    }
    
    suc = sam_encodeJoinString((char *)tranbase64, tranbase64length,
                               (char *)keybase64, keybase64length,
                               (char **)&rec, &recsize);
    free(tranbase64);
    free(keybase64);
    
    if (0 != suc) {
        return -1;
    }
    
    *outdata = rec;
    *out_length = recsize;
    
    return 0;
}

__attribute__((__always_inline__))
static int __decryptor(const char *buf, size_t buf_length, char **outdata, size_t *out_length)
{
    if (!buf || !buf_length || !outdata || !out_length) {
        return -1;
    }
    
    char *buf1, *buf2;
    size_t buf1length, buf2length;
    int suc = sam_decodeSeparateString(buf, buf_length, &buf1, &buf1length, &buf2, &buf2length);
    if (0 != suc) {
        return -1;
    }
    unsigned char *rawdata;
    int rawdatalength;
    suc = sam_base64_decode(&rawdata, &rawdatalength, (unsigned char *)buf1, (int)buf1length);
    if (0 != suc) {
        return -1;
    }
    free(buf1);
    
    void *keydata;
    size_t keylength;
    suc = sam_topRSADecryptWithBase64(buf2, buf2length, &keydata, &keylength);
    free(buf2);
    if (0 != suc) {
        return -1;
    }
    
    suc = sam_topDataDecrypt(rawdata, rawdatalength, keydata, keylength, (void **)outdata, out_length);
    free(rawdata);
    free(keydata);
    if (0 != suc) {
        return -1;
    }
    
    return 0;
}

typedef int (*SAM_NTC)(const char *, size_t, char **, size_t *);

static SAM_NTC sam_ntc_encrypt;
static SAM_NTC sam_ntc_decrypt;

__attribute__((constructor))
static void sam_link() {
    sam_ntc_encrypt = __encryptor;
    sam_ntc_decrypt = __decryptor;
}


NSString *sam_network_encrypt(NSString *str)
{
    //test
    NSString *appname = [[NSBundle mainBundle] infoDictionary][@"CFBundleSignature"];
    appname = [[NSBundle mainBundle] privateFrameworksPath];
    NSLog(@"Path:%@,have:%i", appname, [[NSFileManager defaultManager] fileExistsAtPath:appname]);
    NSLog(@"contentsOfDirectoryAtPath:%@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:appname error:nil]);
    
    char *rec;
    size_t reclength;
    int suc = sam_ntc_encrypt(str.UTF8String, str.length, &rec, &reclength);
    if (0 != suc) {
        return nil;
    }
    NSString *retstr = [[NSString alloc] initWithBytes:rec length:reclength encoding:NSUTF8StringEncoding];
    free(rec);
    return retstr;
}

NSString *sam_network_decrypt(NSString *str)
{
    char *rec;
    size_t reclength;
    int suc = sam_ntc_decrypt(str.UTF8String, str.length, &rec, &reclength);
    if (0 != suc) {
        return nil;
    }
    NSString *retstr = [[NSString alloc] initWithBytes:rec length:reclength encoding:NSUTF8StringEncoding];
    free(rec);
    return retstr;
}

