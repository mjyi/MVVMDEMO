//
//  PostsItemViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostsItemViewModel.h"
#import "PostModel.h"

@implementation PostsItemViewModel


- (NSString *)authorString {
    
    NSString *tags = [[[self.post.tags rac_sequence] map:^id(Tags *tag) {
        return tag.title;
    }] foldLeftWithStart:@" " reduce:^id(id accumulator, id value) {
        return [accumulator stringByAppendingString:value];
    }];
    
    return [NSString stringWithFormat:@"%@ @%@",self.post.author.name, tags];
}

@end
