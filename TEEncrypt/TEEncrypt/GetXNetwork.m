//
//  GetXNetwork.m
//  GetX
//
//  Created by songbo on 14-12-25.
//  Copyright (c) 2014年 GetX Labs. All rights reserved.
//

#import "GetXNetwork.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSString+URLEncoding.h"
#import "FCUUID.h"
#import <PinEncrypt/PinEBase.h>
#import "TBMacros.h"
#import "GxMeta.h"
#import "GxRequest.h"
#import "GxResponse.h"
#import "GxError.h"
#import "GxPlatform.h"
#import "GetXErrorHandler.h"

static NSInteger kGetXRequestTimeout = 15;
NSString *const kGetXRequestMethodHttpGet    = @"GET";
NSString *const kGetXRequestMethodHttpPost   = @"POST";
NSString *const kGetXRequestMethodHttpPut    = @"PUT";
NSString *const kGetXRequestMethodHttpDelete = @"DELETE";

@interface GetXNetwork()
{

}

@end



@implementation GetXNetwork


#pragma mark -
#pragma mark - Status Code

+ (BOOL)hasAcceptableStatusCode:(int)responseCode
{
    // 定义可以接受的状态码
    NSIndexSet *acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];

    return [acceptableStatusCodes containsIndex:responseCode];
}


#pragma mark -
#pragma mark - Wrapper for Decoder

+ (id)decodeData:(NSData *)data withEncoding:(NSStringEncoding)encoding
{
    if (data == nil)
    {
        return nil;
    }

    @try {
        // this is important for performance, see here: https://github.com/johnezang/JSONKit
        if (encoding == NSUTF8StringEncoding)
        {
            return [[JSONDecoder decoder] mutableObjectWithData:data];
        }
        else
        {
            NSString *string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:encoding];
            return [string mutableObjectFromJSONString];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"WARNING: failed to decode JSON response from server\n\nException: %@\n\nData: %@", exception, [[NSString alloc] initWithData:data encoding:encoding]);
    }
    @finally {

    }

    return nil;
}


#pragma mark -
#pragma mark - Wrapper for Decoder

+ (void)logError:(NSString *)event error:(GxError *)error
{
    if (IsEmpty(event) || error == nil)
    {
        return;
    }

    [EasyLog logEvent:event withParamName1:kEasyLogParamErrorCode andValue1:[@(error.code) stringValue] paramName2:kEasyLogParamErrorType andValue2:error.type paramName3:kEasyLogParamErrorMessage andValue3:error.message];

}


#pragma mark -
#pragma mark - GET / POST Request

- (void)getPath:(NSString *)path
        baseUrl:(NSString *)baseUrl
   absolutePath:(NSString *)absolutePath
  requestMethod:(NSString *)requestMethod
     parameters:(NSMutableDictionary *)parameters
     completion:(GxNetWorkSuccessBlock)completion
        failure:(GxNetWorkErrorBlock)failure
        context:(GetXNetworkContext *)context
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        // parameters must not be nil

        NSURL *absurl = nil;
        if (IsEmpty(absolutePath))
        {
            absurl = [self _URLWithBaseUrl:baseUrl path:path parameters:parameters];
        }
        else
        {
            absurl = [NSURL URLWithString:absolutePath];
        }

        INFO(@"GET URL: %@", absurl.absoluteString);

        __block NSString *requestMethodName = requestMethod ? requestMethod : @"";
        __weak __block ASIHTTPRequest *httprequest = [ASIHTTPRequest requestWithURL:absurl];
        [httprequest setValidatesSecureCertificate:NO];
        httprequest.requestMethod = kGetXRequestMethodHttpGet;
        httprequest.timeOutSeconds = kGetXRequestTimeout;

        [self buildHoneyMood:httprequest method:httprequest.requestMethod host:baseUrl path:path body:nil params:parameters];

        [httprequest addRequestHeader:@"X-Extra" value:@"tgps"];

        [httprequest setCompletionBlock:^{

            __block NSData *responseData = [httprequest responseData];
            __block NSStringEncoding responseEncoding = [httprequest responseEncoding];
            __block int responseStatusCode = [httprequest responseStatusCode];
            INFO(@"GetPath completed: %d", responseStatusCode);

            completion(responseEncoding, responseStatusCode, responseData);

            [EasyLog logEvent:requestMethodName withParamName1:kEasyLogParamErrorCode andValue1:[@(responseStatusCode) stringValue] paramName2:kEasyLogParamErrorMessage andValue2:@"ok"];
        }];

        [httprequest setFailedBlock:^{

            int responseStatusCode = [httprequest responseStatusCode];
            NSError *responseError = [httprequest error];
            NSInteger errorCode = responseError ? [responseError code] : responseStatusCode;
            NSString *errorType = @"CustomHttpException";
            NSString *errorMessage = responseError ? [responseError localizedDescription] : @"unknown error.";
            INFO(@"GetPath failed: %ld", errorCode);

            GxError *gxError = [[GxError alloc] init];
            gxError.code = errorCode;
            gxError.domain = kGetXNetworkRequestErrorDomain;
            gxError.type = errorType;
            gxError.message = [NSString stringWithFormat:@"[http]: %@", errorMessage];

            if (failure)
            {
                failure(gxError);
            }

            [[self class] logError:requestMethodName error:gxError];
            return;
        }];

        [httprequest startAsynchronous];
    });
}


- (void)postPath:(NSString *)path
         baseUrl:(NSString *)baseUrl
        isDelete:(BOOL)isDelete
   requestMethod:(NSString *)requestMethod
      parameters:(NSMutableDictionary *)parameters
      postparams:(NSMutableDictionary *)postparams
      completion:(GxNetWorkSuccessBlock)completion
         failure:(GxNetWorkErrorBlock)failure
         context:(GetXNetworkContext *)context
{
    // postparams must not be nil

    NSURL *absurl = [self _URLWithBaseUrl:baseUrl path:path parameters:parameters];
    INFO(@"POST URL: %@", absurl.absoluteString);
    INFO(@"Parameter: %@", postparams);

    __block NSString *requestMethodName = requestMethod ? requestMethod : @"";
    __weak __block ASIFormDataRequest *formdatarequest = [ASIFormDataRequest requestWithURL:absurl];
    [formdatarequest setValidatesSecureCertificate:NO];
    formdatarequest.timeOutSeconds = kGetXRequestTimeout;

    if (isDelete)
    {
        formdatarequest.requestMethod = kGetXRequestMethodHttpDelete;
    }
    else
    {
        formdatarequest.requestMethod = kGetXRequestMethodHttpPost;
    }

    NSData *postBodyData = [postparams JSONDataWithOptions:JKSerializeOptionNone error:nil];
    [formdatarequest appendPostData:postBodyData];

    NSString *requestBody = [[NSString alloc] initWithData:postBodyData encoding:NSUTF8StringEncoding];

    [self buildHoneyMood:formdatarequest method:formdatarequest.requestMethod host:baseUrl path:path body:requestBody params:nil];

    [formdatarequest addRequestHeader:@"X-Extra" value:@"tgps"];

    [formdatarequest setCompletionBlock:^{

        __block NSData *responseData = [formdatarequest responseData];
        __block NSStringEncoding responseEncoding = [formdatarequest responseEncoding];
        __block int responseStatusCode = [formdatarequest responseStatusCode];
        INFO(@"GetPath completed: %d", responseStatusCode);

        completion(responseEncoding, responseStatusCode, responseData);

        [EasyLog logEvent:requestMethodName withParamName1:kEasyLogParamErrorCode andValue1:[@(responseStatusCode) stringValue] paramName2:kEasyLogParamErrorMessage andValue2:@"ok"];
    }];

    [formdatarequest setFailedBlock:^(void){

        int responseStatusCode = [formdatarequest responseStatusCode];
        NSError *responseError = [formdatarequest error];
        NSInteger errorCode = responseError ? [responseError code] : responseStatusCode;
        NSString *errorType = @"CustomHttpException";
        NSString *errorMessage = responseError ? [responseError localizedDescription] : @"unknown error.";
        INFO(@"GetPath failed: %ld", errorCode);

        GxError *gxError = [[GxError alloc] init];
        gxError.code = errorCode;
        gxError.domain = kGetXNetworkRequestErrorDomain;
        gxError.type = errorType;
        gxError.message = [NSString stringWithFormat:@"[http]: %@", errorMessage];

        if (failure)
        {
            failure(gxError);
        }

        [[self class] logError:requestMethodName error:gxError];
        return;
    }];

    [formdatarequest startAsynchronous];
}

- (void)cryptHost:(NSString *)host
             path:(NSString *)path
           method:(NSString *)method
       methodName:(NSString *)methodName
           params:(NSDictionary *)params
       completion:(GxNetWorkSuccessBlock)completion
          failure:(GxNetWorkErrorBlock)failure {

    // postparams must not be nil

    NSURL *absurl = [NSURL URLWithString:host];
    INFO(@"POST URL: %@", absurl.absoluteString);

    __block NSString *requestMethodName = methodName ? methodName : @"";
    __weak __block ASIFormDataRequest *formdatarequest = [ASIFormDataRequest requestWithURL:absurl];
    [formdatarequest setValidatesSecureCertificate:NO];
    formdatarequest.timeOutSeconds = kGetXRequestTimeout;
    formdatarequest.requestMethod = kGetXRequestMethodHttpPost;
    NSDictionary *k9Dic = [self buildK9Dic:method path:path params:params];
    NSData *postBodyData = [k9Dic JSONDataWithOptions:JKSerializeOptionNone error:nil];
    [formdatarequest appendPostData:postBodyData];
    [formdatarequest addRequestHeader:@"Content-Type" value:@"application/json"];
    [formdatarequest addRequestHeader:@"X-Extra" value:@"tgps"];

    [formdatarequest setCompletionBlock:^{

        __block NSData *responseData = [formdatarequest responseData];
        __block NSStringEncoding responseEncoding = [formdatarequest responseEncoding];
        __block int responseStatusCode = [formdatarequest responseStatusCode];
        INFO(@"GetPath completed: %d", responseStatusCode);

        completion(responseEncoding, responseStatusCode, responseData);

        [EasyLog logEvent:requestMethodName withParamName1:kEasyLogParamErrorCode andValue1:[@(responseStatusCode) stringValue] paramName2:kEasyLogParamErrorMessage andValue2:@"ok"];
    }];

    [formdatarequest setFailedBlock:^(void){

        int responseStatusCode = [formdatarequest responseStatusCode];
        NSError *responseError = [formdatarequest error];
        NSInteger errorCode = responseError ? [responseError code] : responseStatusCode;
        NSString *errorType = @"CustomHttpException";
        NSString *errorMessage = responseError ? [responseError localizedDescription] : @"unknown error.";
        INFO(@"GetPath failed: %ld", errorCode);

        GxError *gxError = [[GxError alloc] init];
        gxError.code = errorCode;
        gxError.domain = kGetXNetworkRequestErrorDomain;
        gxError.type = errorType;
        gxError.message = [NSString stringWithFormat:@"[http]: %@", errorMessage];

        if (failure)
        {
            failure(gxError);
        }

        [[self class] logError:requestMethodName error:gxError];
        return;
    }];

    [formdatarequest startAsynchronous];
}


#pragma mark -
#pragma mark Url Handler

- (NSURL *)_URLWithBaseUrl:(NSString *)baseUrl path:(NSString *)path parameters:(NSMutableDictionary *)parameters
{
    NSURL *absUrl = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:baseUrl]];
    if (parameters)
    {
        absUrl = [NSURL URLWithString:[[absUrl absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", [self _queryStringFromParameters:parameters]]];
    }

    return absUrl;
}

- (NSString *)_queryStringFromParameters:(NSDictionary *)parameters
{
    NSMutableArray *mutableParameterComponents = [NSMutableArray array];
    for (id key in [parameters allKeys])
    {
        NSString *component = [NSString stringWithFormat:@"%@=%@", [key description], [[[parameters valueForKey:key] description] encodedURLParameterString]];
        [mutableParameterComponents addObject:component];
    }

    return [mutableParameterComponents componentsJoinedByString:@"&"];
}


#pragma mark -
#pragma mark Common Method

- (NSDictionary *)buildK9Dic:(NSString *)method path:(NSString *)path params:(NSDictionary *)params {

    if (IsEmpty(method) || IsEmpty(path) || IsEmpty(params)) {
        return nil;
    }

    NSString *query = nil;
    if ([method isEqualToString:kGetXRequestMethodHttpGet]) {

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
    NSString *body = EncryptWithJString(jString);
    return @{
             @"zv" : @"gps", //标明用新的加密方式
             @"data": body
             };
}

- (void)buildHoneyMood:(ASIHTTPRequest *)request method:(NSString *)method host:(NSString *)host path:(NSString *)path body:(NSString *)body params:(NSDictionary *)params
{
    NSString *salt = @"";
    if ([method isEqualToString:kGetXRequestMethodHttpGet])
    {
        if (!IsEmpty(host) && !IsEmpty(path) && !IsEmpty(params))
        {
            salt = EncryptWithStringsAndDic(method, host, path, params);
        }
    }
    else
    {
        if (!IsEmpty(host) && !IsEmpty(path) && !IsEmpty(body))
        {
            salt = EncryptWithStrings(method, host, path, body);
        }

        [request addRequestHeader:@"Content-Type" value:@"application/json"];
    }

    [request addRequestHeader:@"Sesame-Signature" value:salt];
}

- (NSString *)buildNetworkTimestamp
{
    // 13位
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"SSS"];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld%@", (NSInteger)[date timeIntervalSince1970], [formatter stringFromDate:date]];
    if (IsEmpty(timeStamp))
    {
        timeStamp = @"";
    }

    return timeStamp;
}

- (NSString *)buildNetworkRequestId
{
    NSString *requestId = [FCUUID uuid];
    if (IsEmpty(requestId))
    {
        requestId = @"";
    }

    return requestId;
}


- (NSString *)buildIDFA
{
    NSString *idfd = @"";
    if (NSClassFromString(@"ASIdentifierManager"))
    {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
        {
            NSString *tmpIdfd = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (!IsEmpty(tmpIdfd))
            {
                idfd = tmpIdfd;
            }
        }
    }

    return idfd;
}


@end

