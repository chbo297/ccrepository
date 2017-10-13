//
//  NSData+AES.m
//  TEEncrypt
//
//  Created by bo on 12/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (AES)

- (NSData *)AES256EncryptWithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          keyPtr,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
    
//    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
//    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
//    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
//
//    // fetch key data
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    NSUInteger dataLength = [self length];
//
//    //See the doc: For block ciphers, the output size will always be less than or
//    //equal to the input size plus the size of one block.
//    //That's why we need to add the size of one block here
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode,
//                                          keyPtr, kCCKeySizeAES256,
//                                          NULL /* initialization vector (optional) */,
//                                          [self bytes], dataLength, /* input */
//                                          buffer, bufferSize, /* output */
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        //the returned NSData takes ownership of the buffer and will free it on deallocation
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//
//    free(buffer); //free the buffer;
//    return nil;
}

- (NSData *)AES256DecryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

@end
