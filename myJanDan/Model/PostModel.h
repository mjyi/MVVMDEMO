//
//  PostModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseModel.h"

@class Author,Tag;
@class Author,Comments_Rank,Tags,Categories,Comments;
@interface PostModel : BaseModel

@property (nonatomic, copy) NSString *thumb_c;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSArray<Categories *> *categories;

@property (nonatomic, copy) NSString *modified;

@property (nonatomic, copy) NSArray<Comments *> *comments;

@property (nonatomic, copy) NSString *excerpt;

@property (nonatomic, strong) Author *author;

@property (nonatomic, copy) NSArray<Comments *> *comments_rank;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title_plain;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSArray<Tags *> *tags;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *comment_status;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSArray *attachments;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *content;



@end


@interface Author : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *last_name;


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *first_name;

@end

//@interface Comments_Rank : NSObject
//
//@property (nonatomic, assign) NSInteger parent;
//
//@property (nonatomic, copy) NSString *content;
//
//@property (nonatomic, assign) NSInteger index;
//
//@property (nonatomic, assign) NSInteger ID;
//
//@property (nonatomic, assign) NSInteger vote_negative;
//
//@property (nonatomic, copy) NSString *date;
//
//@property (nonatomic, assign) NSInteger vote_positive;
//
//@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, copy) NSString *url;
//
//@end

@interface Tags : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger post_count;

@end

@interface Categories : NSObject

@property (nonatomic, assign) NSInteger post_count;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger parent;

@end

@interface Comments : NSObject

@property (nonatomic, assign) NSInteger parent;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger vote_negative;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger vote_positive;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@end

