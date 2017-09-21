//
//  JDViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/16.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"

@interface JDViewModel ()

@end


@implementation JDViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

#pragma mark - JDRequestProtocol

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

-(id)analysisOfResponse:(id)response {
    return nil;
}

@end
