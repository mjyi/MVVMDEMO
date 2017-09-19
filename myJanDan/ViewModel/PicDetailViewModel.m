//
//  PicDetailViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/9/7.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PicDetailViewModel.h"
#import "PicModel.h"

@implementation PicDetailViewModel


- (void)initialize {
    [super initialize];
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(PicModel *input) {
        @strongify(self)
        RACSignal *signal = [self requestRemoteDataSignalWithParam:input.comment_ID];
        return [[signal map:^id(id value) {
            @strongify(self)
            PicDetailModel *pDetail = self.picDetail;
            return pDetail;
        }] catch:^RACSignal *(NSError *error) {
            return [RACSignal error:error];
        }];    
    }];
    
}

/**
 根据id和slug请求数据  TODO: local store
 
 @param param 参数（id/slug)
 @return request Signal
 */
- (RACSignal *)requestRemoteDataSignalWithParam:(id)param {
    
    return [[[JDHTTPService tucao_SignalWithCommentID:param] map:^id(NSDictionary *value) {
        
        return value;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal error:error];
    }];
    return [RACSignal empty];
    
}


@end
