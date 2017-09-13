//
//  PostItemModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"tags" : [Tags class],
             @"categories": [Categories class],
             @"comments": [Comments class],
             @"comments_rank": [Comments class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}


- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSArray *thumbs = dic[@"custom_fields"][@"thumb_c"];
    if (thumbs.count) {
        _thumb_c = thumbs[0];
    }
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (![object isMemberOfClass:self.class]) return NO;
    PostModel *post = (PostModel *)object;
    return (self.ID == post.ID);
}

#pragma mark - Protocol

- (NSString *)date {
    return _date;
}

@end

@implementation Author

@end


@implementation Tags

@end


@implementation Categories

@end


@implementation Comments

@end


