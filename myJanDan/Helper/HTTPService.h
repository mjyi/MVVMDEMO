//
//  HTTPService.h
//  myJanDan
//
//  Created by mervin on 2017/8/15.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

#define JDHTTPService  [HTTPService shareInstance]

static NSString* const kPostsURL = @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,comment_count,slug,custom_fields&custom_fields=thumb_c,views&dev=1&page=";

static NSString* const kPostById = @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_post&custom_fields=thumb_c,views&id=";

static NSString * const kPostBySlug = @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_post&custom_fields=thumb_c,views&slug=";

static NSString * const kPicURL = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=";

static NSString * const kXXOOURL = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=";

static NSString * const kDuanURL = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=";



@interface HTTPService : MKNetworkHost

/**
 单例
 */
+ (HTTPService *)shareInstance;

/**
 新鲜事列表
 */
- (RACSignal *)posts_signalWithPage:(NSInteger)page;

/**
 新鲜事详情
 */
- (RACSignal *)postDetail_signalWithId:(NSInteger)ID;

/**
 无聊图
 */
- (RACSignal *)pic_signalWithPage:(NSInteger)page;


/**
 妹子图
 */
- (RACSignal *)xxoo_signalWithPage:(NSInteger)page;

/**
  段子
 */
- (RACSignal *)duan_SignalWithPage:(NSInteger)page;

@end

static NSString* const BoredPicturesUrl = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=";

//妹子图
static NSString* const SisterPicturesUrl = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=";

//段子
static NSString* const JokeUrl = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=";

//小视频
static NSString* const littleMovieUrl = @"http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_video_comments&page=";

//评论数量
static NSString* const commentCountUrl = @"http://jandan.duoshuo.com/api/threads/counts.json?threads=";

//新鲜事详情
static NSString* const freshNewDetailUrl = @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_post&include=content&id=";

//新鲜事评论
static NSString* const freshNewCommentlUrl = @"http://jandan.net/?oxwlxojflwblxbsapi=get_post&include=comments&id=";

//发表评论接口
static NSString* const pushCommentlUrl = @"http://jandan.net/?oxwlxojflwblxbsapi=respond.submit_comment";

//投票
static NSString* const commentVoteUrl=@"http://jandan.net/index.php?acv_ajax=true&option=%@&ID=%@";

//多说评论列表 无聊图
static NSString* const duoShuoCommentListlUrl=@"http://jandan.duoshuo.com/api/threads/listPosts.json?thread_key=";

//多说发表评论 无聊图
static NSString* const duoShuoPushCommentUrl=@"http://jandan.duoshuo.com/api/posts/create.json";
