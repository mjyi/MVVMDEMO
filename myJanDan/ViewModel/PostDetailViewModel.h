//
//  PostDetailViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/17.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"
#import "PostDetailModel.h"

@interface PostDetailViewModel : JDViewModel

@property (nonatomic, strong) PostDetailModel *postDetail;
@property (nonatomic, strong) RACCommand *sourceCommand;

@end
