//
//  SAMOCCryptor.m
//  TEEncrypt
//
//  Created by bo on 15/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SAMOCCryptor.h"
#import "SAMAESCrpytor.h"
#import "SAMRSACryptor.h"
#import "SAMCStringUtil.h"

NSString *sam_network_encryptor(NSString *str)
{
    char *r32 = sam_generateRandom32Char();
    size_t keylength = 32;
    
    void *rec;
    size_t recsize = 0;
    int suc = sam_topDataEncrypt(str.UTF8String, str.length, r32, keylength, &rec, &recsize);
    if (suc != 0) {
        return nil;
    }
    
    unsigned char *tranbase64;
    int tranbase64length;
    suc = sam_base64_encode(&tranbase64, &tranbase64length, rec, (int)recsize);
    free(rec);
    if (0 != suc) {
        return nil;
    }
    char *keybase64;
    size_t keybase64length = 0;
    suc = sam_topRSAEncryptToBase64(r32, keylength, &keybase64, &keybase64length);
    free(r32);
    if (0 != suc) {
        return nil;
    }
    
    suc = sam_encodeJoinString((char *)tranbase64, tranbase64length,
                               (char *)keybase64, keybase64length,
                               (char **)&rec, &recsize);
    free(tranbase64);
    free(keybase64);
    
    if (0 != suc) {
        return nil;
    }
    NSString *finalstr = [[NSString alloc] initWithBytes:rec length:recsize encoding:NSUTF8StringEncoding];
    free(rec);
    recsize= 0;
    
    if (finalstr.length <= 0) {
        return nil;
    }
    
    return finalstr;
}

NSString *sam_network_decryptor(NSString *str)
{
    char *buf1, *buf2;
    size_t buf1length, buf2length;
    int suc = sam_decodeSeparateString(str.UTF8String, str.length, &buf1, &buf1length, &buf2, &buf2length);
    if (0 != suc) {
        return nil;
    }
    unsigned char *rawdata;
    int rawdatalength;
    suc = sam_base64_decode(&rawdata, &rawdatalength, (unsigned char *)buf1, (int)buf1length);
    if (0 != suc) {
        return nil;
    }
    free(buf1);
    
    void *keydata;
    size_t keylength;
    suc = sam_topRSADecryptWithBase64(buf2, buf2length, &keydata, &keylength);
    free(buf2);
    if (0 != suc) {
        return nil;
    }
    
    void *outdata;
    size_t outlength;
    suc = sam_topDataDecrypt(rawdata, rawdatalength, keydata, keylength, &outdata, &outlength);
    free(rawdata);
    free(keydata);
    if (0 != suc) {
        return nil;
    }
    
    NSString *odatastr = [[NSString alloc] initWithBytes:outdata length:outlength encoding:NSUTF8StringEncoding];
    free(outdata);
    return odatastr;
}
