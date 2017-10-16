//
//  AXRequest.m
//  TEEncrypt
//
//  Created by bo on 10/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "AXRequest.h"
#import "AFNetworking.h"
#import "ECPTC.h"
#import "AES.h"
#import "RSAUtil.h"
#import "CocoaSecurity.h"
#import "NSData+AES.h"
#import "SAMTC.h"
#import "PinECT.h"
//#import "SAMCCryptor.h"

#import "SAMOCCryptor.h"

#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHiiseTfrvnSHDOmbCl/DwjFns\
Qf45GG+bw2FtNW28AAHPWWFRvUBVsgiNWg889r6q9NFqu+lCxi4lkhqk/mSam+nJ\
VWMxbDHwMVVKq/1t2hu5tzc0BvdUlX+NuZx5mH9oND/YTZ584itQJCkFCqifimTo\
Bm+NL1KNP0bjE6s6CQIDAQAB"
//私钥
#define RSA_Privite_key        @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMeKKx5N+u+dIcM6\
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
A5tAx1tsmycAVYs="

//#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCxuWhp6EgQfrrSBtxlBwbU35lhjC67X0Y1KrhqolIfYo3/yWV1eryYVUhk5xeHsbKg9RHD9TpIZRUWIW5a8MrMBcgr1A/dgIHi2EM28drH4JRTmkTLVHReggFbb046k0ISpLW3XVW0jHB3/z3S1c/NT9V63SQK6WJ65/YP5xISNQIDAQAB"
////私钥
//#define RSA_Privite_key        @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALG5aGnoSBB+utIG3GUHBtTfmWGMLrtfRjUquGqiUh9ijf/JZXV6vJhVSGTnF4exsqD1EcP1OkhlFRYhblrwyswFyCvUD92AgeLYQzbx2sfglFOaRMtUdF6CAVtvTjqTQhKktbddVbSMcHf/PdLVz81P1XrdJArpYnrn9g/nEhI1AgMBAAECgYBEbsMAvLs69sFS6+djU1BTGYIC6Kp55ZawFDIMhVIf2aAZ1N+nW8pQ0c3dZIpP6qGAjrz3em6lv55d9iN7Cura/g57Rk4S3SRo5u4hWUd16NeIVP+HfreKIgZ6jwKQTfXt2KzDuIAHudvwT2UJBePgIIDQoKMEq4khtFiRGS1UgQJBAN/KpSOiRiGup8h/Iqespwfxyrqn5/4iyw1tpJCWzHddP7nJGpYmOL+ELWs/pReYclAOqH9ZIzOT2K8ZLt6yBOECQQDLTXZowK8wFgMudAE5TStC/zl3TAKMu/Gu5wlXSMoa+nwSy/FSIQZyypGeHR2X8QhbZ1Qz+uBCJm7gEGOWMWPVAkEAp5ajsFm3V0XqE/VRSGu88fAaN0nCK8h2cunm0Ph8ye6k6EY3iLW6zYD4WlZhFZhuEpHHkQZ5nAhdvlKHjPGXQQJAYOtF1rx9B/SGgb/F0ZZrWF4p/ChdUtBKcHIt7tGBoAjn22IkYl3iIBlYAEOrFwNOU5zX9IvWG1MNKn5Fq5VSHQJBAJG5xSY0IKzXWDsGnPIa9XlSTv1zl7RCGNDo7O1zh+5J/kjDpU9M2fIXEtzvGYHiOffz9FBh5ka69JJNFWoWAiw="

//#define RSA_Public_key @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArB8PDMl4z0zbeZuJI0lY\
//kBTNX486DvqA9G19Dh+cYugz0QDYmLuDQgy9bo8utwhzzuIeLEw5gICvH9b1j9AR\
//qaUJYmaNJnu/a8fhICYKLtCqZDzpASg2U7lowppIBASzCKAdL7Oq8MVI2gZHCyov\
//J/EFr4czLI1qMQsKE9WHHsxZooqfAZzFbwN1kAtEljhd366H6EbfWdZbXSeNW0UA\
//ZQeTHGHfieRliFnIp5leDpWo2LGCK8fZ5+eHYVw73cptKAeFSTfFxOO1MLQ/NerW\
//fQqXyTJb5iPzBp6poLP2ULtt1pBdEKu15irCMQeo8cpLzj2pa/fWOAg0yYzIl8c0\
//9wIDAQAB"
//
//#define RSA_Public_key2 @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKrkpReU5KMIxw+gUaM1qLZLms\
//3lGRAENJBZhlc53LCbrXVXoJ5EQFawcA6359ZZLMbOdBfn2s3L7kxTOmF56nlXJE\
//4ufzP73HAFUDeQpcc9pJPZ614vyfHu4iZuj3R8e8V/Pluq7npmIpX8x+HS9U8HHA\
//GFDspf7u9PIRZ3BXvQIDAQAB"
//
//#define RSA_Private_key @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALG5aGnoSBB+utIG\
//3GUHBtTfmWGMLrtfRjUquGqiUh9ijf/JZXV6vJhVSGTnF4exsqD1EcP1OkhlFRYh\
//blrwyswFyCvUD92AgeLYQzbx2sfglFOaRMtUdF6CAVtvTjqTQhKktbddVbSMcHf/\
//PdLVz81P1XrdJArpYnrn9g/nEhI1AgMBAAECgYBEbsMAvLs69sFS6+djU1BTGYIC\
//6Kp55ZawFDIMhVIf2aAZ1N+nW8pQ0c3dZIpP6qGAjrz3em6lv55d9iN7Cura/g57\
//Rk4S3SRo5u4hWUd16NeIVP+HfreKIgZ6jwKQTfXt2KzDuIAHudvwT2UJBePgIIDQ\
//oKMEq4khtFiRGS1UgQJBAN/KpSOiRiGup8h/Iqespwfxyrqn5/4iyw1tpJCWzHdd\
//P7nJGpYmOL+ELWs/pReYclAOqH9ZIzOT2K8ZLt6yBOECQQDLTXZowK8wFgMudAE5\
//TStC/zl3TAKMu/Gu5wlXSMoa+nwSy/FSIQZyypGeHR2X8QhbZ1Qz+uBCJm7gEGOW\
//MWPVAkEAp5ajsFm3V0XqE/VRSGu88fAaN0nCK8h2cunm0Ph8ye6k6EY3iLW6zYD4\
//WlZhFZhuEpHHkQZ5nAhdvlKHjPGXQQJAYOtF1rx9B/SGgb/F0ZZrWF4p/ChdUtBK\
//cHIt7tGBoAjn22IkYl3iIBlYAEOrFwNOU5zX9IvWG1MNKn5Fq5VSHQJBAJG5xSY0\
//IKzXWDsGnPIa9XlSTv1zl7RCGNDo7O1zh+5J/kjDpU9M2fIXEtzvGYHiOffz9FBh\
//5ka69JJNFWoWAiw="

static BOOL isEmpty(NSString *str) {
    if (!str || str.length <= 0) {
        return YES;
    }
    return NO;
}

@implementation AXRequest

+ (AFHTTPSessionManager *)sessionManager {
    static AFHTTPSessionManager *sm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sm = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        sm.requestSerializer = [AFJSONRequestSerializer new];
        sm.requestSerializer.timeoutInterval = 10;
        [sm.requestSerializer setValue:@"tgps" forHTTPHeaderField:@"X-Extra"];
    });
    return sm;
}

+ (void)cryptHost:(NSString *)host
             path:(NSString *)path
           method:(NSString *)method
           params:(NSDictionary *)params
       completion:(void (^)(id respondObj))completion
          failure:(void (^)(NSError *error))failure {
    
    params = @{@"key1":@"value", @"dd": [NSNull null]};
    NSDictionary *k9Dic = [self buildK9Dic:@"POST" path:@"test" params:params];
    
    [[self.class sessionManager] POST:@"http://101.200.58.6/test"
                           parameters:k9Dic
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  if (completion) {
                                      completion(responseObject);
                                  }
                                  
                              }
                              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  if (failure) {
                                      failure(error);
                                  }
                              }];
    
}



+ (NSDictionary *)buildK9Dic:(NSString *)method path:(NSString *)path params:(NSDictionary *)params {

//    if (isEmpty(method) || IsEmpty(path) || IsEmpty(params)) {
//        return nil;
//    }
//    [self generateRandom32Char];
    NSString *query = nil;
    if ([method isEqualToString:@"GET"]) {

        query = [self _queryStringFromParameters:params];
    }

    NSDictionary *dic = @{
                          @"method": method,
                          @"path": path,
                          @"query": query.length > 0 ? query : [NSNull null],
                          @"body": query.length > 0 ? [NSNull null] : params,
                          @"command": [NSNull null],
                          @"errlib" : [NSNull null]
                          };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *ks = @"";
    for (int i=0; i<1; i++) {
        ks = [ks stringByAppendingString:jString];
    }
//    NSString *key = [self generateRandom32Char];
//    NSString *body = EncryptWithJString(jString);
    NSString *body = [self encryptStr:ks key:nil];
//    NSString *body = jString;
    return @{
             @"zv" : @"gps", //标明用新的加密方式
             @"data": body
             };
}


+ (NSString *)_queryStringFromParameters:(NSDictionary *)parameters
{
    NSMutableArray *mutableParameterComponents = [NSMutableArray array];
    for (id key in [parameters allKeys])
    {
        
        NSString *component = [NSString stringWithFormat:@"%@=%@", [key description], AFPercentEscapedStringFromString([[parameters valueForKey:key] description])];
        [mutableParameterComponents addObject:component];
    }
    
    return [mutableParameterComponents componentsJoinedByString:@"&"];
}

+ (NSString *)encryptStr:(NSString *)str key:(NSString *)key
{
    char *rsr;
    size_t rsz;
//    sam_ntc_encrypt(str.UTF8String, str.length, &rsr, <#size_t *out_Length#>)
//    sam_ntc_encrypt()
//    sam_ntc_encrypt(<#const char *buf#>, <#size_t buf_length#>, <#char **outdata#>, <#size_t *out_Length#>)
//    NSString *stt = sam_network_encryptor(str);
//    NSLog(@"%@", stt);
//    NSString *oos = sam_network_decryptor(stt);
//    NSLog(@"%@", oos);
    
    return nil;
//    char *r32 = sam_generateRandom32Char();
//    key = [NSString stringWithUTF8String:r32];
//    free(r32);
//
//
//    if (isEmpty(str) || isEmpty(key)) {
//        return nil;
//    }
////    NSString *utf8str = [str UTF8String];
////    CocoaSecurityResult *aessresu = [CocoaSecurity aesEncrypt:str key:key];
//    void *rec;
//    size_t recsize = 0;
//    int suc = sam_topEncrypt(str.UTF8String, str.length, key.UTF8String, key.length, &rec, &recsize);
//    if (suc != 0 || recsize <= 0) {
//        return nil;
//    }
//    NSData *aesdata = [NSData dataWithBytes:rec length:recsize];
//    free(rec);
//    NSString *aesstr = [aesdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
//    NSData *keyutf8data = [key dataUsingEncoding:NSUTF8StringEncoding];
////    suc = sam_topRSAEncrypt(keyutf8data.bytes, keyutf8data.length, &rec, &recsize);
////    suc = sam_topRSAEncrypt(key.UTF8String, key.length, rec, &recsize);
//    if (0 != suc) {
//        return nil;
//    }
//    NSData *samenkey = [NSData dataWithBytes:rec length:recsize];
//    free(rec);
//    NSString *b64samenkey = [[NSString alloc] initWithData:[samenkey base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
////    NSString *b64samenkey = [samenkey base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
//    NSString *b64UTIenkey = [RSAUtil encryptString:key publicKey:RSA_Public_key];
//
////    NSString *rsaenkey2 = [NSString stringWithCharacters:rec length:recsize];
//
//    NSString *res = [self customJoinStr:aesstr xkey:b64UTIenkey];
//
//    NSString *ookey = [RSAUtil decryptString:b64UTIenkey privateKey:RSA_Privite_key];
//    NSString *oosamkey = [RSAUtil decryptString:b64samenkey privateKey:RSA_Privite_key];
////    suc = sam_topDecryptBase64Buf(aesstr.UTF8String, aesstr.length, ookey.UTF8String, ookey.length, &rec, &recsize);
//
////    suc = sam_topRSADecrypt(samenkey.bytes, samenkey.length, &rec, &recsize);
//    NSLog(@"%s", rec);
//    [NSArray new][2];
//    exit(0);
//    char *tc = malloc(36);
//    memcpy(tc, &"0123456789abcdefghijklmnopqrstuvwxyz"[0], 36);
//    printf("%s\n", tc);
//    sam_tf_data(tc, 36);
//    printf("%s\n", tc);
//    sam_tf_reverse_data(tc, 36);
//    printf("%s\n", tc);
//    return res;
}

//+ (NSString *)customTranfromStr:(NSString *)str
//{
//    return str;
//}
//
//+ (NSString *)customJoinStr:(NSString *)str xkey:(NSString *)xkey
//{
//    char *outb;
//    size_t outlength;
//    if (0 == sam_encodeJoinString(str.UTF8String, str.length, xkey.UTF8String, xkey.length, &outb, &outlength)) {
//        if (outb) {
//            NSString *rt = [NSString stringWithUTF8String:outb];
//            free(outb);
//            return rt;
//        }
//    }
//    return nil;
//}
//
//


//+ (NSString *)generateRandom32Char
//{
//    int buflength = 32;
//    char arcbuf[buflength + 1];
//    memset(arcbuf, 0, buflength + 1);
//
//    for (int i = 0; i < buflength; i++) {
//        char tempc = 0;
//        uint32_t arcn = arc4random_uniform(36);
//        if (arcn < 10) {
//            tempc = arcn + '0';
//        } else {
//            tempc = arcn - 10 + 'a';
//        }
//        arcbuf[i] = tempc;
//    }
//
//
//    return [NSString stringWithUTF8String:arcbuf];
//}

@end
