//
//  ViewController.m
//  TERuntimeDestruct
//
//  Created by bo on 04/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DLIntrospection.h"
#import <objc/runtime.h>


@interface Father : NSObject
//@property (nonatomic, copy) NSString *name;
- (void)teachBaby;

- (void)walk;

@end

@implementation Father

- (void)teachBaby {
    
}

- (void)walk {
    NSLog(@"father walk");
}

- (void)dealloc {
    NSLog(@"father dealloc");
}


@end

@interface CanGo : NSObject
@property (nonatomic, copy) NSArray *toys;

- (void)gogo;


@end

@implementation CanGo

- (void)gogo {
    NSLog(@"CanGo :gogo");
}
@end

@interface Son : Father
@property (nonatomic, copy) NSArray *toys;
@property (nonatomic, copy) NSString *school;

- (void)playToy;

//- (void)walk;

@end

@implementation Son {
    CanGo *_cango;
    
}

- (CGFloat)wawa {
    NSLog(@"- wawa");
    return 7.7;
}

- (CGFloat)wawa2 {
    NSLog(@"- wawa");
    return 7.8;
}

+ (void)wawa {
    NSLog(@"+ wawa");
}

- (void)walk {
    NSLog(@"son walk");
}

- (id)init
{
    NSLog(@"befor:%@", self);
    self.toys = @[@"saiche", @"jiqiren"];
    self = [super init];
    if (self) {
        NSLog(@"1.%@", NSStringFromClass([self class]));
        NSLog(@"1.%@", self);
        NSLog(@"2.%@", NSStringFromClass([super class]));
        NSLog(@"2.%@", [super class]);
        
        [self walk];
        [super walk];
        
//        NSLog(@"cmd:%s", _cmd);
    }
    return self;
}

- (id)copy {
    NSLog(@"copy");
    return self;
}

//- (void)gogo {
//    NSLog(@"son gogo");
//}

//- (BOOL)respondsToSelector:(SEL)aSelector {
//    NSLog(@"respondsToSelector:%s", aSelector);
//    return [super respondsToSelector:aSelector];
//}
//
//+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
//    BOOL is = [[super superclass] instancesRespondToSelector:aSelector];
//    NSLog(@"instancesRespondToSelector:%s,%i", aSelector, is);
//    return is;
//}

//- (IMP)methodForSelector:(SEL)aSelector {
//    IMP imp = [super methodForSelector:aSelector];
//    NSLog(@"methodForSelector:%s,%s", aSelector, imp)
//    return imp;
//}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    BOOL is = [[super superclass] resolveInstanceMethod:sel];
//    if (!is && sel == @selector(gogo)) {
//        class_addMethod(self, sel, [[CanGo new] methodForSelector:sel], "v@:");
//        return YES;
//    }
//    return is;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(gogo)) {
//        return [CanGo new];
//    }
//    return nil;
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
////    _cango = [CanGo new];
//    return [[CanGo new] methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@"forwardInvocation : %@", anInvocation);
//    [anInvocation invokeWithTarget:[CanGo new]];
//}

- (void)playToy {
    NSLog(@"%@", self.toys);
}

- (void)dealloc {
//    NSLog(@"son dealloc");
}

@end

@interface ViewController ()

@property (nonatomic) Son *sss;

@property (assign, atomic) int abv;


@end

@implementation ViewController {
//    Son *_sss;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    {
        // before new
        Son *son = [Son new];
//        [son performSelector:@selector(gogo)];
//        son.name = @"sark";
//        son.toys = @[@"sunny", @"xx"];
        // after new
//        NSLog(@"%@", [[son class] instanceMethods]);
//        NSLog(@"%@", [son.superclass instanceMethods]);
//        NSLog(@"%@", [[son.superclass superclass] instanceMethods]);
//        NSLog(@"%@", son);
//        self.sss = son;
//        NSLog(@"%@", self.sss);
//        NSLog(@"%@", son);
//        [son playToy];
//        [son willChangeValueForKey:<#(nonnull NSString *)#>]
//        [son performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#> modes:<#(nullable NSArray<NSString *> *)#>]
//        [son performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>]
//        [self willChangeValueForKey:@"sd"];
//        self.sss = son;
//        son.school = @"hongqi";
//        NSLog(@"school:%@", [son valueForKey:@"school"]);
        id tesid = son.class;
        
//        [son wawa];
//        [son.class wawa];
//        [son perf]
//        NSLog(@"%@", son);
//        NSMethodSignature *sign = [son methodSignatureForSelector:@selector(wawa2)];
//        NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sign];
//        invo.target = son;
//        invo.selector = @selector(wawa);
//        [invo invoke];
//        CGFloat ff = 0.f;
//        [invo getReturnValue:&ff];
        [son performSelector:@selector(wawa)];
//        NSLog(@"-waea is %f", ff);
//        NSLog(@"+waea is %i", [son.class respondsToSelector:@selector(wawa)]);
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"did:%@", self.sss);
}



//@synthesize sss = _sss2;
//
//- (void)setSss:(Son *)sss {
//    NSLog(@"%@", sss);
//    _sss = sss;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
