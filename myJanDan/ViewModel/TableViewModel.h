//
//  TableViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"

@interface TableViewModel : JDViewModel

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldInfiniteScrolling;

@property (nonatomic, strong) RACCommand *didSelected;

//- (id)fetchLocalData;

//- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
