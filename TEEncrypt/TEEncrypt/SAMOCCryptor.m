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
    NSData *cryptdata = [NSData dataWithBytes:rec length:recsize];
    free(rec);
    recsize= 0;
    NSString *tranbase64 = sam_base64StringWithdata(cryptdata);
    NSString *keybase64 = sam_topRSAEncryptToBase64(r32, keylength);
    free(r32);
    if (tranbase64.length<=0 || keybase64.length<=0) {
        return nil;
    }
    
    suc = sam_encodeJoinString(tranbase64.UTF8String, tranbase64.length,
                               keybase64.UTF8String, keybase64.length,
                               (char **)&rec, &recsize);
    
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
    NSString *b64datastr = [[NSString alloc] initWithBytes:buf1 length:buf1length encoding:NSUTF8StringEncoding];
    free(buf1);
    NSData *odata = sam_dataWithBase64String(b64datastr);
    
    NSString *b64ksc = [[NSString alloc] initWithBytes:buf2 length:buf2length encoding:NSUTF8StringEncoding];
    free(buf2);
    void *outdata;
    size_t outlength;
    suc = sam_topRSADecryptWithBase64(b64ksc, &outdata, &outlength);
    if (0 != suc) {
        return nil;
    }
    NSString *keystr = [[NSString alloc] initWithBytes:outdata length:outlength encoding:NSUTF8StringEncoding];
    free(outdata);
    if (keystr.length <= 0) {
        return nil;
    }
    
    suc = sam_topDataDecrypt(odata.bytes, odata.length, keystr.UTF8String, keystr.length, &outdata, &outlength);
    if (0 != suc) {
        return nil;
    }
    
    NSString *odatastr = [[NSString alloc] initWithBytes:outdata length:outlength encoding:NSUTF8StringEncoding];
    free(outdata);
    return odatastr;
}
