//
//  UnitTest_DemoTests.m
//  UnitTest_DemoTests
//
//  Created by XDS on 16/9/6.
//  Copyright © 2016年 xds. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"

#import "NetworkHelper.h"

@interface UnitTest_DemoTests : XCTestCase<NetworkHelperDelegate>

@property (nonatomic,strong) ViewController *vc;

@property (nonatomic,assign) int statusCode;

@end

@implementation UnitTest_DemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    // 实例化需要测试的类
    self.vc = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    // 销毁实例化对象
    self.vc = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//简单测试
- (void)testSimpleExample {
    NSInteger result = [self.vc getNum];
    XCTAssertEqual(result, 100, @"测试不通过");
}

- (void)testAsyncExample {
    NetworkHelper *helper = [[NetworkHelper alloc] initWithDelegate:self];
    //如果请求的网址是http开头的，需要在同级目录下的info.plist文件中设置App Transport Security Settings才能访问，具体不再阐述。。。
    [helper getStatusCodeForSite:@"https://www.apple.com"];
    NSLog(@"------------------ Waiting ------------------");
    CFRunLoopRun();
    XCTAssertEqual(self.statusCode, 200, @"Can not access this site");
    NSLog(@"------------------ Finished ------------------");
}

- (void)succeedGotStatusCode:(int)code {
    self.statusCode = code;
    CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
    CFRunLoopStop(runLoopRef);
}

- (void)failedGotStatusCodeWithError:(NSError *)error {
    NSLog(@"----------------- Error:%@ ------------------", error);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (NSInteger i = 0; i < 100; i ++) {
            NSLog(@"====UnitTest====%ld====", i);
        }
    }];
}

@end
