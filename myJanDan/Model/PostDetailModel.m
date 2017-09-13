//
//  PostDetailModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostDetailModel.h"

@implementation PostDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"post" : [PostModel class]};
}


#pragma mark - Protocol
-(NSString *)date {
    return _post.date;
}

@end
