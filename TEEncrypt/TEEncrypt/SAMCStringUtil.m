//
//  SAMCStringUtil.m
//  TEEncrypt
//
//  Created by bo on 15/10/2017.
//  Copyright © 2017 SAM. All rights reserved.
//

#import "SAMCStringUtil.h"

NSString *sam_base64StringWithdata(NSData *data)
{
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

NSData *sam_dataWithBase64String(NSString *str)
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}
