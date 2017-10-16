//
//  SAMRSACryptor.m
//  TEEncrypt
//
//  Created by bo on 16/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SAMRSACryptor.h"
#import "SAMCStringUtil.h"


static char *sam_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHiiseTfrvnSHDOmbCl/DwjFnsQf45GG+bw2FtNW28AAHPWWFRvUBVsgiNWg889r6q9NFqu+lCxi4lkhqk/mSam+nJVWMxbDHwMVVKq/1t2hu5tzc0BvdUlX+NuZx5mH9oND/YTZ584itQJCkFCqifimToBm+NL1KNP0bjE6s6CQIDAQAB\0";

static char *sam_private_key = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMeKKx5N+u+dIcM6\
ZsKX8PCMWexB/jkYb5vDYW01bbwAAc9ZYVG9QFWyCI1aDzz2vqr00Wq76ULGLiWS\
GqT+ZJqb6clVYzFsMfAxVUqr/W3aG7m3NzQG91SVf425nHmYf2g0P9hNnnziK1Ak\
KQUKqJ+KZOgGb40vUo0/RuMTqzoJAgMBAAECgYEAthmJCin+ROhwpHtKxnHlZ5Ge\
ivca6746NLuU0RZ+Y6DaBgG6x97ftJU6Ks2ytF82WEv+RdrhoJe+C3mPqV2kLrxs\
pB48YupwDt9RE/Fc8RkhrnkfqPiTzLty9+09J3tDVFuNKaXY56tdS6XK2qsacE0l\
07eekv8dvdpXoc4sapUCQQDjV/k/mP8twFEnLWiNApeN4NCLf1hOM7+94fiRK9x5\
9vTyykCI6np8qM9FVcc0q4/AOUHJoNYHZkRY/G5RjJM3AkEA4LEBWhAHUU+8tGv4\
Ai/SJCv7nHGC4zVWYP4pW6CoLYGbjzeZu6TJU4P9FYihOo7Ms8M7clTPYjwKIgza\
fju8vwJAezPlw21qfKTIVe7pxeEtuJmo6rAsbtTkiEa5qhKW/RG0VQ7+QjSwBHaH\
PQ/rUMPYt1dQK7CZzJDDYWYLcu43qQJAIGRkNX+qDmbYZYpLLsWGHgDZPSyAGhFO\
ap05iSQYGrdcncD+QLb47zlP+xK/a5m6mQ/EOi9P1nGhZFdGCHzEMQJBAODO1BCt\
NPIUELM0jYLzBooMOr095RUMC7KmApovhdjgmTVtGQTaibEhRFUUWhSx3RHLTMf3\
A5tAx1tsmycAVYs=\0";

//#define RSA_Privite_key        @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMeKKx5N+u+dIcM6\
//ZsKX8PCMWexB/jkYb5vDYW01bbwAAc9ZYVG9QFWyCI1aDzz2vqr00Wq76ULGLiWS\
//GqT+ZJqb6clVYzFsMfAxVUqr/W3aG7m3NzQG91SVf425nHmYf2g0P9hNnnziK1Ak\
//KQUKqJ+KZOgGb40vUo0/RuMTqzoJAgMBAAECgYEAthmJCin+ROhwpHtKxnHlZ5Ge\
//ivca6746NLuU0RZ+Y6DaBgG6x97ftJU6Ks2ytF82WEv+RdrhoJe+C3mPqV2kLrxs\
//pB48YupwDt9RE/Fc8RkhrnkfqPiTzLty9+09J3tDVFuNKaXY56tdS6XK2qsacE0l\
//07eekv8dvdpXoc4sapUCQQDjV/k/mP8twFEnLWiNApeN4NCLf1hOM7+94fiRK9x5\
//9vTyykCI6np8qM9FVcc0q4/AOUHJoNYHZkRY/G5RjJM3AkEA4LEBWhAHUU+8tGv4\
//Ai/SJCv7nHGC4zVWYP4pW6CoLYGbjzeZu6TJU4P9FYihOo7Ms8M7clTPYjwKIgza\
//fju8vwJAezPlw21qfKTIVe7pxeEtuJmo6rAsbtTkiEa5qhKW/RG0VQ7+QjSwBHaH\
//PQ/rUMPYt1dQK7CZzJDDYWYLcu43qQJAIGRkNX+qDmbYZYpLLsWGHgDZPSyAGhFO\
//ap05iSQYGrdcncD+QLb47zlP+xK/a5m6mQ/EOi9P1nGhZFdGCHzEMQJBAODO1BCt\
//NPIUELM0jYLzBooMOr095RUMC7KmApovhdjgmTVtGQTaibEhRFUUWhSx3RHLTMf3\
//A5tAx1tsmycAVYs="

__attribute__((__always_inline__))
static NSData* sam_stripPublicKeyHeader(NSData *d_key)
{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

__attribute__((__always_inline__))
static NSData* sam_stripPrivateKeyHeader(NSData *d_key)
{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

__attribute__((__always_inline__))
static SecKeyRef sam_addPrivateKey(NSString *key)
{
    //    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    //    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    //    if(spos.location != NSNotFound && epos.location != NSNotFound){
    //        NSUInteger s = spos.location + spos.length;
    //        NSUInteger e = epos.location;
    //        NSRange range = NSMakeRange(s, e-s);
    //        key = [key substringWithRange:range];
    //    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = sam_stripPrivateKeyHeader(data);
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"SAM_RSA_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

__attribute__((__always_inline__))
static SecKeyRef sam_addPublicKey(NSString *key)
{
    //    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    //    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    //    if(spos.location != NSNotFound && epos.location != NSNotFound){
    //        NSUInteger s = spos.location + spos.length;
    //        NSUInteger e = epos.location;
    //        NSRange range = NSMakeRange(s, e-s);
    //        key = [key substringWithRange:range];
    //    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    data = sam_stripPublicKeyHeader(data);
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"SAM_RSA_PubicKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

__attribute__((__always_inline__))
static int sam_encryptWithSecKey(const void *databuf, size_t data_length, SecKeyRef keyRef, void **outdata, size_t *out_Length)
{
    if (!outdata || !out_Length || !databuf || !data_length || !keyRef) {
        return -1;
    }
    const uint8_t *srcbuf = (const uint8_t *)databuf;
    size_t srclen = data_length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    size_t src_block_size = block_size - 11;
    
    void *retbuf = malloc(1024);
    memset(retbuf, 0, 1024);
    size_t writeidx = 0;
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(keyRef,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               retbuf + writeidx,
                               &outlen
                               );
        if (status != 0) {
            free(retbuf);
            return status;
        }else{
            writeidx += outlen;
        }
    }
    *outdata = retbuf;
    *out_Length = writeidx;
    return 0;
}

__attribute__((__always_inline__))
static int sam_decryptWithSecKey(const void *databuf, size_t data_length, SecKeyRef keyRef, void **outdata, size_t *out_Length)
{
    if (!outdata || !out_Length || !databuf || !data_length || !keyRef) {
        return -1;
    }
    
    const uint8_t *srcbuf = (const uint8_t *)databuf;
    size_t srclen = data_length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    void *retbuf = malloc(1024);
    memset(retbuf, 0, 1024);
    size_t writeidx = 0;
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            free(outbuf);
            free(retbuf);
            return status;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            int tlength = idxNextZero-idxFirstZero-1;
            memcpy(retbuf, outbuf+idxFirstZero+1, tlength);
            writeidx += tlength;
        }
    }
    free(outbuf);
    *outdata = retbuf;
    *out_Length = writeidx;
    return 0;
}

__attribute__((__always_inline__))
static int sam_rsaEncrypt(const char *buf, size_t buf_length, void **outdata, size_t *out_Length)
{
    if (!buf || !buf_length || !outdata || !out_Length) {
        return 0-1;
    }
    
    static SecKeyRef keyRefpu = nil;
    if(!keyRefpu){
        keyRefpu = sam_addPublicKey([NSString stringWithUTF8String:sam_public_key]);
    }
    
    if (!keyRefpu) {
        return -1;
    }
    return sam_encryptWithSecKey(buf, buf_length, keyRefpu, outdata, out_Length);
}

__attribute__((__always_inline__))
static int sam_rsaDecrypt(const void *data, size_t data_length, void **outdata, size_t *out_Length)
{
    if (!data || !data_length || !outdata || !out_Length) {
        return 0-1;
    }
    
    static SecKeyRef keyRefpr = nil;
    if(!keyRefpr){
        keyRefpr = sam_addPrivateKey([NSString stringWithUTF8String:sam_private_key]);
    }
    
    if (!keyRefpr) {
        return -1;
    }
    return sam_decryptWithSecKey(data, data_length, keyRefpr, outdata, out_Length);
}

NSString *sam_topRSAEncryptToBase64(const char *buf, size_t buf_length)
{
    void *rec;
    size_t reclength = 0;
    if (sam_rsaEncrypt(buf, buf_length, &rec, &reclength) == 0)
    {
        if (reclength > 0) {
            NSString *base64str = sam_base64StringWithdata([NSData dataWithBytes:rec length:reclength]);
            free(rec);
            return base64str;
        }
    }
    return nil;
}

int sam_topRSADecryptWithBase64(NSString *str, void **outdata, size_t *out_Length)
{
    if (str.length <= 0 || !outdata || !out_Length) {
        return -1;
    }
    
    NSData *normaldata = sam_dataWithBase64String(str);
    
    return sam_rsaDecrypt(normaldata.bytes, normaldata.length, outdata, out_Length);
}
