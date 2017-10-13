//
//  SAMOCEncryptLib.m
//  TEEncrypt
//
//  Created by bo on 12/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SAMOCEncryptLib.h"
//#import <CommonCrypto/CommonHMAC.h>
//#import <CommonCrypto/CommonCryptor.h>

@implementation SAMOCEncryptLib

static NSData *sam_base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

NSData* sam_stripPublicKeyHeader(NSData *d_key)
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

SecKeyRef sam_addPublicKey(NSString *key)
{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = sam_base64_decode(key);
    data = sam_stripPublicKeyHeader(data);
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
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

int sam_encryptWithSecKey(NSData *data, SecKeyRef keyRef, void **outdata, size_t *out_Length)
{
    if (!outdata || !out_Length || !data || !keyRef) {
        return -1;
    }
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
//    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    void *retbuf = malloc(srclen * 2);
    size_t writeidx = 0;
    
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
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
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            return -1;
        }else{
            writeidx += outlen;
        }
    }
    *outdata = retbuf;
    *out_Length = writeidx;
    CFRelease(keyRef);
    return 0;
}

int sam_rsaEncryptWithPublicKey(const char *buf, size_t buf_length, const char *publickey, size_t key_length, void **outdata, size_t *out_Length)
{
    if (!buf || !buf_length || !publickey || key_length != 32 || !outdata || !out_Length) {
        return -1;
    }
    
    SecKeyRef keyRef = sam_addPublicKey([[NSString alloc] initWithBytes:publickey length:key_length encoding:NSUTF8StringEncoding]);
    if(!keyRef){
        return -1;
    }
    return sam_encryptWithSecKey([NSData dataWithBytes:buf length:buf_length], keyRef, outdata, out_Length);
}

//int generateHexStrWithData(void *data, size_t data_length, bool lower,  void **outdata, size_t *out_Length)
//{
//    if (!data || !data_length || !outdata || !out_Length) {
//        return -1;
//    }
//    
//    static const char HexEncodeCharsLower[] = "0123456789abcdef";
//    static const char HexEncodeChars[] = "0123456789ABCDEF";
//    char *resultData;
//    // malloc result data
//    resultData = malloc(data_length * 2 +1);
//    // convert imgData(NSData) to char[]
//    unsigned char *sourceData = (unsigned char *)data;
//    
//    if (lower) {
//        for (int index = 0; index < data_length; index++) {
//            // set result data
//            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
//            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
//        }
//    }
//    else {
//        for (NSUInteger index = 0; index < data_length; index++) {
//            // set result data
//            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
//            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
//        }
//    }
//    resultData[data_length * 2] = 0;
//    
//    // convert result(char[]) to NSString
//    *outdata = resultData;
//    *out_Length = data_length*2 + 1;
//    sourceData = nil;
//    
//    return 0;
//}


//- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower
//{
//    if (data.length == 0) { return nil; }
//
//    static const char HexEncodeCharsLower[] = "0123456789abcdef";
//    static const char HexEncodeChars[] = "0123456789ABCDEF";
//    char *resultData;
//    // malloc result data
//    resultData = malloc([data length] * 2 +1);
//    // convert imgData(NSData) to char[]
//    unsigned char *sourceData = ((unsigned char *)[data bytes]);
//    NSUInteger length = [data length];
//
//    if (isOutputLower) {
//        for (NSUInteger index = 0; index < length; index++) {
//            // set result data
//            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
//            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
//        }
//    }
//    else {
//        for (NSUInteger index = 0; index < length; index++) {
//            // set result data
//            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
//            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
//        }
//    }
//    resultData[[data length] * 2] = 0;
//
//    // convert result(char[]) to NSString
//    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
//    sourceData = nil;
//    free(resultData);
//
//    return result;
//}

@end


