//
//  PicModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseModel.h"
#import "Pic_ViewModel.h"

typedef NS_ENUM(NSUInteger, PicBadgeType) {
    PicBadgeTypeNone = 0,   // 正常图片
    PicBadgeTypeLong,       // 长图
    PicBadgeTypeGIF,        // GIF
};

@class PictureMeta;

@interface PicModel : BaseModel

@property (nonatomic, copy) NSString *comment_date;

@property (nonatomic, copy) NSString *comment_approved;

@property (nonatomic, copy) NSString *comment_author_url;

@property (nonatomic, copy) NSString *comment_parent;

@property (nonatomic, copy) NSString *comment_subscribe;

@property (nonatomic, copy) NSString *comment_author;

@property (nonatomic, copy) NSString *vote_positive;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *comment_reply_ID;

@property (nonatomic, copy) NSString *sub_comment_count;

@property (nonatomic, copy) NSString *vote_ip_pool;

@property (nonatomic, copy) NSString *comment_author_email;

@property (nonatomic, copy) NSString *text_content;

@property (nonatomic, copy) NSString *comment_type;

@property (nonatomic, copy) NSString *comment_ID;

@property (nonatomic, copy) NSString *comment_author_IP;

@property (nonatomic, strong) NSMutableArray<PictureMeta *> *pics;

@property (nonatomic, copy) NSString *comment_agent;

@property (nonatomic, copy) NSString *comment_content;

@property (nonatomic, copy) NSString *vote_negative;

@property (nonatomic, copy) NSString *comment_post_ID;

@property (nonatomic, copy) NSString *comment_date_gmt;

@property (nonatomic, copy) NSString *comment_karma;

@property(nonatomic, assign) PicType type;

@property (nonatomic, assign, readonly) CGFloat height; // cell's height

@end

@interface PictureMeta : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) CGFloat width;     // pixel

@property (nonatomic, assign) CGFloat height;    // pixel

@property (nonatomic, assign) PicBadgeType badgeType;

@property (nonatomic, assign) YYImageType type;
@end
