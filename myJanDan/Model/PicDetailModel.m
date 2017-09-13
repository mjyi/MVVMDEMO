//
//  PicDetailModel.m
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PicDetailModel.h"
#import "TucaoModel.h"
#import "PicModel.h"

@implementation PicDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"hot_tucao" : [TucaoModel class],
             @"tucao": [TucaoModel class]};
}

- (NSString *)date {
    return self.pic.date;
}

@end
