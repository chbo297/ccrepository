//
//  CCRunloopSensing.m
//  TEThreadLock
//
//  Created by bo on 12/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "CCRunloopSensing.h"

@interface CCRunloopSensing ()

@property (nonatomic) NSDate *dataTag;
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) NSInteger count;

@end

@implementation CCRunloopSensing

+ (instancetype)single {
    static CCRunloopSensing *sensing;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sensing = [[self alloc] init];
    });
    return sensing;
}

+ (void)startRun {
    [self single];
}

+ (void)endRun {
    
}

- (void)beginReckon:(NSDate *)date {
    //run in runloop observe, (main thread, or the thread is detected)
    self.dataTag = date;
}

- (void)endReckon:(NSDate *)date {
    //run in runloop observe, (main thread, or the thread is detected)
    if (self.dataTag) {
        NSTimeInterval interval = [date timeIntervalSinceDate:self.dataTag];
        
        printf("间隔:%f\n", interval);
        self.count += 1;
        printf("数量 : %ld", self.count);
        
        self.dataTag = nil;
    }
    
}


-(void)observer
{
    //1.创建监听者
    /*
     第一个参数:怎么分配存储空间
     第二个参数:要监听的状态 kCFRunLoopAllActivities 所有的状态
     第三个参数:时候持续监听
     第四个参数:优先级 总是传0
     第五个参数:当状态改变时候的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        /*
         kCFRunLoopEntry = (1UL << 0),        即将进入runloop
         kCFRunLoopBeforeTimers = (1UL << 1), 即将处理timer事件
         kCFRunLoopBeforeSources = (1UL << 2),即将处理source事件
         kCFRunLoopBeforeWaiting = (1UL << 5),即将进入睡眠
         kCFRunLoopAfterWaiting = (1UL << 6), 被唤醒
         kCFRunLoopExit = (1UL << 7),         runloop退出
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         */
        switch (activity) {
            case kCFRunLoopEntry:
                break;
            case kCFRunLoopBeforeTimers:
                break;
            case kCFRunLoopBeforeSources:
                break;
            case kCFRunLoopBeforeWaiting:
                [self endReckon:[NSDate date]];
                break;
            case kCFRunLoopAfterWaiting:
                [self beginReckon:[NSDate date]];
                break;
            case kCFRunLoopExit:
                break;
            default:
                break;
        }
    });
    
    /*
     第一个参数:要监听哪个runloop
     第二个参数:观察者
     第三个参数:运行模式
     */
    CFRunLoopAddObserver(CFRunLoopGetMain(),observer, kCFRunLoopCommonModes);
    
    //NSDefaultRunLoopMode == kCFRunLoopDefaultMode
    //NSRunLoopCommonModes == kCFRunLoopCommonModes
}

@end
