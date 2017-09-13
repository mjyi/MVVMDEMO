//
//  JDRequestProtocol.h
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JDRequestProtocol <NSObject>

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
