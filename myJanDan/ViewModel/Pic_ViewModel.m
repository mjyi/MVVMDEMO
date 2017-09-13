//
//  Pic_ViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Pic_ViewModel.h"
#import "PicModel.h"
#import "RequestRemoteSize.h"

@interface Pic_ViewModel ()

@property(nonatomic, strong) RequestRemoteSize *sizeHost;

@end

@implementation Pic_ViewModel

- (void)initialize {
    [super initialize];
    self.page = 1;
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    @weakify(self)
    [self.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *execting) {
        @strongify(self)
        if (execting.boolValue) {
            self.title = loading_Title;
        } else {
            switch (self.type) {
                case PicTypePIC:
                    self.title = pic_Title;
                    break;
                case PicTypeXXOO:
                    self.title = xxoo_Title;
                    break;
                case PicTypeJoke:
                    self.title = duan_Title;
                    break;
            }
        }
    }];
    self.sizeHost = [[RequestRemoteSize alloc] init];
    
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    self.curPage = page;
    RACSignal *signal = [RACSignal empty];
    switch (_type) {
        case PicTypePIC:
            signal = [JDHTTPService pic_signalWithPage:page];
            break;
        case PicTypeXXOO:
            signal = [JDHTTPService xxoo_signalWithPage:page];
            break;
        case PicTypeJoke:
            signal = [JDHTTPService duan_SignalWithPage:page];
            break;
    }
    
    @weakify(self)
    
    return [signal flattenMap:^RACStream *(NSDictionary *value) {
        @strongify(self)
        int count = [[value valueForKey:@"count"] intValue];
        if (self.perPage < 0) self.perPage = count;
        NSMutableArray *signals = [NSMutableArray array];
        for (NSDictionary *dic in value[@"comments"]) {
            PicModel *model = [PicModel modelWithDictionary:dic];
            model.type = self.type;
            
            RACSignal *p_S = [self picSizeFromRemoteURL:model];
            
            [signals addObject:p_S];
        }
        return [[RACSignal combineLatest:signals] map:^id(id value) {
//            DebugLog(@"%@", value);
            return value;
        }];
    }];
}

- (RACSignal *)picSizeFromRemoteURL:(PicModel*)pic {
    RACSignal *signal = [RACSignal return: pic];
    if (pic.pics.count) {
        PictureMeta *fir_meta = pic.pics[0];
        signal = [[self.sizeHost requsetRemoteSize:fir_meta.url] map:^id(NSValue *x) {
            CGSize size = x.CGSizeValue;
            fir_meta.width = size.width;
            fir_meta.height = size.height;
            return pic;
        }];
    }
    return signal;
}

@end
