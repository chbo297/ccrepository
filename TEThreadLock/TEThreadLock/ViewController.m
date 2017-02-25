//
//  ViewController.m
//  TEThreadLock
//
//  Created by bo on 24/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "TETableVC.h"

@interface ViewController ()

@property (nonatomic) CALayer *containerLayer;
@property (nonatomic) CALayer *tranLayer;
@property (nonatomic) UIWindow *window;

@property (nonatomic) NSDate *date;

@property (nonatomic) NSInteger lianxu;

@property (nonatomic) NSInteger danci;

@property (nonatomic) NSInteger num;

@property (nonatomic) UIView *aniView;

@property (nonatomic) dispatch_queue_t queue;

@property (nonatomic) UIViewController *vc;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer:self.containerLayer];
    self.containerLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    
    UIViewController *rootViewController = [[TETableVC alloc] init];
//    [rootViewController.view setBackgroundColor:[UIColor blueColor]];
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
//    button.backgroundColor = [UIColor yellowColor];
//    [button addTarget:self action:@selector(but:) forControlEvents:UIControlEventTouchUpInside];
//    [rootViewController.view addSubview:button];
    
//    NSFileManager
    self.aniView = [[UIView alloc] initWithFrame:CGRectMake(150, 500, 50, 50)];
    _aniView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.aniView];
    [self animaleView];
    
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    [window setRootViewController:rootViewController];
    [window setWindowLevel:(UIWindowLevelStatusBar + 1.0f)];
//    [[UIApplication sharedApplication].keyWindow];
//    [window makeKeyAndVisible];
//    [window makeKeyAndVisible];
    self.window = window;
    window.hidden = NO;
//    NSLog(@"%@", [UIApplication sharedApplication].keyWindow);
    NSLog(@"%i", window.hidden);
    //[window setBackgroundColor:[UIColor clearColor]];
    //[window setHidden:NO];
    
    self.queue = dispatch_queue_create("analyze", DISPATCH_QUEUE_SERIAL);
    dispatch_async(self.queue, ^{
        [self observer];
//        [self observerS1];
    });
    NSLog(@"ads");
    NSLog(@"%@", [NSThread callStackSymbols]);
    NSLog(@"%@", [NSThread callStackReturnAddresses]);
    struct timespec spec;
    clock_gettime(_CLOCK_REALTIME, &spec);
    printf("l.kai:%lu.%lu\n", spec.tv_sec,spec.tv_nsec);
    [NSThread sleepForTimeInterval:1.5];
//    struct timespec spec;
    clock_gettime(_CLOCK_REALTIME, &spec);
    printf("l.iak:%lu.%lu\n", spec.tv_sec,spec.tv_nsec);
    clock_gettime(_CLOCK_REALTIME, &spec);
    printf("l.i2k:%lu.%lu\n", spec.tv_sec,spec.tv_nsec);
    clock_gettime(_CLOCK_REALTIME, &spec);
    printf("l.i3k:%lu.%lu\n", spec.tv_sec,spec.tv_nsec);
    
    
    
    NSDate *datt = [NSDate date];
    printf("d:kai:%f\n", [datt timeIntervalSinceNow]);
    [NSThread sleepForTimeInterval:1.5];
    printf("d:iak:%f\n", [datt timeIntervalSinceNow]);
    printf("d:i2k:%f\n", [datt timeIntervalSinceNow]);
    printf("d:i3k:%f\n", [datt timeIntervalSinceNow]);
//    [self presentAndDismiss];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self presentAndDismiss];
}
- (UIViewController *)vc {
    if (!_vc) {
        _vc = [UIViewController new];
        _vc.view.backgroundColor = [UIColor yellowColor];
    }
    return _vc;
}

- (void)presentAndDismiss {
    [self presentViewController:self.vc animated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:^{
//            [self presentAndDismiss];
        }];
    }];
}

- (void)animaleView {
    printf("anil");
//    __weak typeof(self) sf = self;
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        _aniView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        printf("completion");
    }];
}

- (void)beginReckon:(NSDate *)date {

    printf("开始计时");
    self.date = date;
}

- (void)endReckon:(NSDate *)date {
    if (self.date) {
        NSTimeInterval interval = [date timeIntervalSinceDate:self.date];
        
        printf("间隔:%f\n", interval);
        self.num += 1;
        printf("数量 : %ld", self.num);
        
        self.date = nil;
    }
    
}


- (IBAction)but:(id)sender {
    printf("but");
//    NSLog(@"but");
}

- (CALayer *)containerLayer {
    if (!_containerLayer) {
        _containerLayer = [CALayer layer];
        _containerLayer.backgroundColor = [UIColor greenColor].CGColor;
        CALayer *layer = [self layerWithImage:@"wjn.jpg"];
        [_containerLayer addSublayer:layer];
        _containerLayer.bounds = CGRectMake(0, 0, 100, 100);
        layer.frame = _containerLayer.bounds;
        
        layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
//        layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }
    return _containerLayer;
}

- (CALayer *)layerWithImage:(NSString *)imageName {
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:imageName].CGImage;
    return layer;
}


-(void)observer
{
    NSLog(@"thread:%@", [NSThread currentThread]);
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
//        dispatch_source_t
//        NSLog(@"thread:%@", [NSThread currentThread]);
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                self.num = 0;
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source事件");
//                [NSThread sleepForTimeInterval:0.02];
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
//                [self endReckon:[NSDate date]];
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
//                [self beginReckon:[NSDate date]];
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop退出");
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

-(void)observerS1
{
//    NSLog(@"thread:%@", [NSThread currentThread]);
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
        //        dispatch_source_t
        //        NSLog(@"thread:%@", [NSThread currentThread]);
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"2即将进入runloop");
                self.num = 0;
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"2即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"2即将处理source事件");
                [NSThread sleepForTimeInterval:0.2];
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"2即将进入睡眠");
                //                [self endReckon:[NSDate date]];
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"2被唤醒");
                //                [self beginReckon:[NSDate date]];
                break;
            case kCFRunLoopExit:
                NSLog(@"2runloop退出");
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
