//
//  TucaoModel.h
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseModel.h"

@interface TucaoModel : BaseModel

@property (nonatomic, copy) NSString *comment_reply_ID;

@property (nonatomic, assign) NSInteger is_jandan_user;

@property (nonatomic, copy) NSString *comment_parent;

@property (nonatomic, copy) NSString *comment_ID;

@property (nonatomic, copy) NSString *vote_negative;

@property (nonatomic, copy) NSString *comment_date;

@property (nonatomic, assign) NSInteger comment_date_int;

@property (nonatomic, assign) NSInteger is_tip_user;

@property (nonatomic, copy) NSString *vote_positive;

@property (nonatomic, copy) NSString *comment_post_ID;

@property (nonatomic, copy) NSString *comment_author;

@property (nonatomic, copy) NSString *comment_content;


@end

