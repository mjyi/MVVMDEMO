//
//  PostItemCell.h
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostsItemViewModel;
@interface PostItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

- (void)bindViewModel:(PostsItemViewModel *)model;

@end
