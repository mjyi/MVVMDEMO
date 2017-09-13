//
//  TableViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "TableViewModel.h"
#import "ModelProtocol.h"

@interface TableViewModel ()

@end

@implementation TableViewModel

- (void)initialize {
    [super initialize];
    self.perPage = -1;
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.integerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
    RACSignal *localDataSignal = [self fetchLocalData];
    RACSignal *netDataSignal = self.requestRemoteDataCommand.executionSignals.switchToLatest;

    RAC(self, dataSource) = [[RACSignal
                              merge:@[localDataSignal, netDataSignal]]
                             map:^id(NSArray *list) {
                                 @strongify(self)
                                 NSMutableArray *array = [NSMutableArray array];
                                 if (_curPage > 1) {
                                     [array addObjectsFromArray:self.dataSource[0]];
                                     [array addObjectsFromArray:[list.rac_sequence filter:^BOOL(id item) {

                                         return ![array containsObject:item];
                                     }].array];
                                 } else {
                                     array = [list copy];
                                 }
                                 return @[array];
                             }];
    
    self.didSelected = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        id item = self.dataSource[indexPath.section][indexPath.row];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:item];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }];
    
    RAC(self, title) = [[self.requestRemoteDataCommand executing] map:^id(NSNumber *execting) {
        return execting.boolValue ? loading_Title: posts_Title;
    }];
}

- (id)fetchLocalData {
    self.curPage = 0;
    return [RACSignal return:@[]];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    self.curPage = page;
    return nil;
}

@end
