//
//  PicDetailViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"
#import "PicDetailModel.h"

@interface PicDetailViewModel : JDViewModel

@property (nonatomic, strong) PicDetailModel *picDetail;
@property (nonatomic, strong) RACCommand *sourceCommand;

@end
