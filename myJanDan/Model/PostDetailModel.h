//
//  PostDetailModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseModel.h"
#import "PostModel.h"

@interface PostDetailModel : BaseModel

@property (nonatomic, strong) PostModel *post;

@property (nonatomic, strong) NSString *previous_url;

@property (nonatomic, strong) NSString *next_url;

@end
