//
//  RequestRemoteSize.h
//  myJanDan
//
//  Created by mervin on 2017/8/28.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "MKNetworkHost.h"

@interface RequestRemoteSize : MKNetworkHost

- (RACSignal *)requsetRemoteSize:(NSString *)imgURL;

- (CGSize) decoderSizeWithData:(NSData *)data;

@end
