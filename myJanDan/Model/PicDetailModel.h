//
//  PicDetailModel.h
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "BaseModel.h"
#import "PicModel.h"
#import "TucaoModel.h"

@interface PicDetailModel : BaseModel

@property (nonatomic, strong) PicModel *pic;
@property (nonatomic, copy) NSArray<TucaoModel *> *hot_tucao;
@property (nonatomic, copy) NSArray<TucaoModel *> *tucao;
@property (nonatomic, assign) BOOL has_next_page;

@end
