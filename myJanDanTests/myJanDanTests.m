//
//  myJanDanTests.m
//  myJanDanTests
//
//  Created by mervin on 2017/8/13.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Addition.h"
#import "RequestRemoteSizeHost.h"
#import <ReactiveCocoa.h>
// 低位在前，高位在后
static inline uint16_t swap_data_uint16(uint16_t value) {
    return
    (uint16_t) ((value & 0x00FF) << 8) |
    (uint16_t) ((value & 0xFF00) >> 8) ;
}

static inline uint32_t swap_data_uint32(uint32_t value) {
    return
    (uint32_t)((value & 0x000000FFU) << 24) |
    (uint32_t)((value & 0x0000FF00U) <<  8) |
    (uint32_t)((value & 0x00FF0000U) >>  8) |
    (uint32_t)((value & 0xFF000000U) >> 24) ;
}


@interface myJanDanTests : XCTestCase

@end

@implementation myJanDanTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDateFormat {
    NSString *s1 = @"2017-08-24 15:10:13";
    NSString *transformed = [s1 transformToFuzzyDate];
    
    NSLog(@"%@", transformed);
    
}


- (void)testBytes {
    Byte bytes[] = {0xFF, 0xD8, 0xFF, 0xE0 ,0x00, 0x10, 0x4A,  0x46, 0x49};
    NSData *data = [NSData dataWithBytes:bytes length:9];
    NSLog(@"data: %@", data);
    uint32_t b1;
    [data getBytes:&b1 range:NSMakeRange(0, 4)];
    uint32_t b2 = swap_data_uint32(b1);
    
    uint16_t z1;
    [data getBytes:&z1 range:NSMakeRange(0, 2)];
    uint16_t z2 = swap_data_uint16(z1);
    NSLog(@"%u, %u",b2,z2);
}

@end
