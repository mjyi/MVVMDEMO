//
//  NSString+Addition.h
//  myJanDan
//
//  Created by mervin on 2017/8/19.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

- (NSTimeInterval)timeIntervalFromFormat:(NSString *)format;

- (NSString*)transformToFuzzyDate;

@end
