//
//  ViewController.m
//  TENotification
//
//  Created by bo on 03/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;

@end

@implementation ViewController
- (IBAction)scanno:(id)sender {
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
//        NSLog(@"pending:\n%@", requests);
    }];
    
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
//        NSLog(@"delivered:\n%@", notifications);
    }];
//    NSLog(@"notific:%@", );
    self.l1.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"];
    self.l2.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"notificationres"];
//    NSLog(@"res:%@", );
//    [[UITableViewCell new] updateConstraints]
    
}
- (IBAction)clear:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"mei" forKey:@"notification"];
    [[NSUserDefaults standardUserDefaults] setObject:@"mei" forKey:@"notificationres"];
}
- (IBAction)addnoti:(id)sender {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.badge = [NSNumber numberWithInteger:2];
    content.body = @"body";
    content.categoryIdentifier = @"test.categoryIdentifier";
    content.launchImageName = @"test.launchImageName";
    content.sound = [UNNotificationSound defaultSound];
    content.subtitle = @"test.subtitle";
    content.title = @"test.title";
    content.threadIdentifier = @"test.threadIdentifier";
    content.userInfo = @{@"userinfo1":@"value1",
                         @"userinfo2":@"value2",};
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"test1"
                                                                          content:content
                                                                          trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO]];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"请求%@", error);
    }];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"mei" forKey:@"notification"];
    [[NSUserDefaults standardUserDefaults] setObject:@"mei" forKey:@"notificationres"];
    
    
//    UILocalNotification *notification=[[UILocalNotification alloc]init];
//    //设置调用时间
//    NSTimeInterval timeoffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10.0];
//    date = [date dateByAddingTimeInterval:timeoffset];
//    notification.fireDate=date;//通知触发的时间，10s以后
//    notification.timeZone = [NSTimeZone systemTimeZone];
//    notification.repeatInterval=2;//通知重复次数
//    notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
//    
//    //设置通知属性
//    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
//    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
//    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
//    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
//    
//    //设置用户信息
//    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
//    
//    //调用通知
//    
//    //    [[UNUserNotificationCenter currentNotificationCenter] ]
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [[NSBundle mainBundle] bundleIdentifier]);
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    vv.backgroundColor= [UIColor grayColor];
    [self.view addSubview:vv];
    
    [UIView animateWithDuration:3 animations:^{
        vv.frame = CGRectMake(200, 0, 30, 30);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
