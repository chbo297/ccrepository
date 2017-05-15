//
//  ViewController.m
//  TEDealloc
//
//  Created by bo on 23/02/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import "TEDeinit.h"

@interface ViewController ()

@end

@implementation ViewController
{
    TEDeinit *_ddd;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self test];
//    [self versionCompare:@"asv\r3.4.5.。6.7.8" and:nil result:nil];
//    NSLog(@"%@",);
//    TEDeinit *dede = [TEDeinit new];
//    _ddd = dede;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [dede play];
//    });
    
//    [dede play];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [_ddd play];
//        _ddd = nil;
//    });
    
}

- (void)test {
    /*
     nil 非法
     “” 无有效字符串
     "243" 单个数字串
     “2.1.1” 普通版本号
     "2.  1 \r.2" 是否可过滤有空格等无效字符串
     "v2.1.2.bin"前缀／后缀
     "2.1.2" "2.1.2.0" 长度不一
     "2.1.2" "2.1.2.0.1"
     "2..d..2"非法
     "NoNumber"非法
     "2.1.2&3.4.5"提取出两个版本号，非法
     “.....”非法
     “app1.1.2” @"appLite1.1" 暂不支持对前缀内容做判断
     ...
     */
    
    NSError *error;
    NSComparisonResult result = [self versionCompare:@"app2.1.bin" and:@"2.1.0.1" error:&error];
    
    NSLog(@"res:%ld", result);
    NSLog(@"err:%@", error);
}


- (NSComparisonResult)versionCompare:(NSString *)v1 and:(NSString *)v2 error:(NSError **)error{
    
    //提取格式化后的版本号字符串
    NSString *v1Version = [self extractVersionString:v1];
    NSString *v2Version = [self extractVersionString:v2];
    
    if (nil == v1Version || nil == v2Version) {
        //无效输入
        *error = [NSError errorWithString:@"Error: invalid input"];
        return NSOrderedSame;
    }
    
    return [self comparaFormatVersionStr:v1Version and:v2Version];
    
}

- (NSComparisonResult)comparaFormatVersionStr:(NSString *)v1 and:(NSString *)v2 {
    NSArray<NSString *> *ar1 = [v1 componentsSeparatedByString:@"."];
    NSArray<NSString *> *ar2 = [v2 componentsSeparatedByString:@"."];
    
    __block NSComparisonResult result = NSOrderedSame;
    [ar1 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger num1 = [obj integerValue];
        if (idx < ar2.count) {
            NSInteger num2 = [[ar2 objectAtIndex:idx] integerValue];
            if (num1 != num2) {
                result = num1 - num2;
                *stop = YES;
            }
        } else {
            //前半部分没有比较出大小的情况下，ar1比ar2长
            if (num1 > 0) {
                result = NSOrderedDescending;
                *stop = YES;
            }
        }
        
    }];
    
    //前半部分没有比较出大小的情况下，ar2比ar1长
    if (NSOrderedSame == result && ar2.count > ar1.count) {
        for (NSInteger i = ar1.count; i < ar2.count; i++) {
            NSInteger num = [[ar2 objectAtIndex:i] integerValue];
            if (num > 0) {
                result = NSOrderedAscending;
            }
        }
    }
    
    return result;
    
}

//提取出符合格式的版本号字符串
- (NSString *)extractVersionString:(NSString *)str {
    
    str = [self filterUselessCharacter:str];
    
    if (nil == str || 0 == str.length) {
        return nil;
    }
    
    //根据业务需求定义不同的格式匹配语句
    NSString *regularExpression = @"\\d+(.\\d+)*";
    
    NSRange range = [str rangeOfString:regularExpression options:NSRegularExpressionSearch];
    
    if (NSNotFound != range.location) {
        
        //寻找有没有第二串版本号
        NSUInteger firstResultLength = range.location + range.length;
        NSRange rangeRemain = NSMakeRange(range.location + range.length, str.length - firstResultLength);
        NSRange secondRange = [str rangeOfString:regularExpression options:NSRegularExpressionSearch range:rangeRemain];
        
        //暂只允许唯一一串合法版本号
        if (NSNotFound == secondRange.location) {
            return [str substringWithRange:range];
        }
        
    }
    
    return nil;
}

//过滤掉无用字符串入会车、换行、空格等。
- (NSString *)filterUselessCharacter:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}






@end
