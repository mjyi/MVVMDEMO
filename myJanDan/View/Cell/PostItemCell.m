//
//  PostItemCell.m
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PostItemCell.h"
#import "PostsItemViewModel.h"
#import "PostModel.h"

@implementation PostItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(PostsItemViewModel *)model {
    
    self.thumbView.imageURL = [NSURL URLWithString:model.post.thumb_c];
    self.titleLabel.text = model.post.title;
    self.authorLabel.text = model.authorString;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", model.post.comment_count];
    
}

@end
