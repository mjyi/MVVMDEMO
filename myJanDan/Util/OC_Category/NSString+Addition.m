//
//  NSString+Addition.m
//  myJanDan
//
//  Created by mervin on 2017/8/19.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (NSTimeInterval)timeIntervalFromFormat:(NSString *)format {
    if (!format || [format isEqualToString:@""]) {
        format = dateFormat;
    }
    return [[NSDate dateWithString:self format:format] timeIntervalSince1970];
}

- (NSString*)transformToFuzzyDate {
    NSDate *date = [NSDate dateWithString:self format:dateFormat];
    NSDate *nowDate = [NSDate date];
    if ([[date laterDate:nowDate] isEqualToDate:date]) {
        return self;
    }
    if ([date isToday]) {
        if (date.hour == nowDate.hour) {
            return [NSString stringWithFormat:@"%ld分钟前",(nowDate.minute - date.minute)];
        } else {
            return [NSString stringWithFormat:@"%ld小时前",(nowDate.hour - date.hour)];
        }
    }
    if ([date isYesterday]) {
        return @"昨天";
    }
    return self;
}

@end
