//
//  PostsItemViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"

@class PostModel;
@interface PostsItemViewModel : JDViewModel

@property (nonatomic, strong) PostModel *post;

- (NSString *)authorString;

@end
