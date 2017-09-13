//
//  RequestRemoteSize.m
//  myJanDan
//
//  Created by mervin on 2017/8/28.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "RequestRemoteSize.h"

// 低位在前，高位在后
static inline uint16_t swap_data_uint16(uint16_t value) {
    return
    (uint16_t) ((value & 0x00FF) << 8) |
    (uint16_t) ((value & 0xFF00) >> 8) ;
}

static inline uint32_t swap_data_uint32(uint32_t value) {
    return
    (uint32_t)((value & 0x000000FFU) << 24) |
    (uint32_t)((value & 0x0000FF00U) <<  8) |
    (uint32_t)((value & 0x00FF0000U) >>  8) |
    (uint32_t)((value & 0xFF000000U) >> 24) ;
}

@implementation RequestRemoteSize

- (RACSignal *)requsetRemoteSize:(NSString *)imgURL {
    NSAssert(imgURL, @"image URL Not nil");

    NSValue *zeroValue = [NSValue valueWithCGSize:CGSizeZero];
    NSURL *URL = [NSURL URLWithString:imgURL];
    if (URL == nil)  return [RACSignal return:zeroValue];
    
    if ([[YYImageCache sharedCache] containsImageForKey:imgURL]) {
        UIImage *image = [[YYImageCache sharedCache] getImageForKey:imgURL];
        return [RACSignal return:[NSValue valueWithCGSize:image.size]];
    }
    
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    NSDictionary *header = @{};
    if ([pathExtendsion isEqualToString:@"jpg"] ||
        [pathExtendsion isEqualToString:@"jpeg"]) {
        header = @{@"Range": @"bytes=0-209"};
    } else {
        header = @{@"Range": @"bytes=0-23"};
    }
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        MKNetworkRequest *request = [self requestWithURLString:imgURL];
        [request addHeaders:header];
        request.request.timeoutInterval = 5;
        [request addCompletionHandler:^(MKNetworkRequest *completedRequest) {
            if (completedRequest.error) {
                [subscriber sendNext:zeroValue];
                [subscriber sendCompleted];
            } else {
                NSData *data = completedRequest.responseData;
                CGSize size = [self decoderSizeWithData:data];
                [subscriber sendNext:[NSValue valueWithCGSize:size]];
                [subscriber sendCompleted];
                NSLog(@"allHeaders :%@", completedRequest.response.allHeaderFields);
            }
        }];
        [self startRequest:request];
        return [RACDisposable disposableWithBlock:^{
            [request cancel];
        }];
    }];
    
}
/**
 关于图像文件的头信息内容：
 PNG: 前八个字节：89 50 4E 47 0D 0A 1A 0A 即为：.PNG....
 宽高信息在 第 16 - 23 字节中。
 JPG: 前两个字节：FF D8
 GIF: 前六个字节：47 49 46 38 39|37 61 。即为 GIF89(7)a [取前4个即可]
 BMP: 前两个字节：42 4D，即：BM
 
 */
- (CGSize) decoderSizeWithData:(NSData *)data {
    YYImageType type = YYImageDetectType((__bridge CFDataRef _Nonnull)(data));
    NSUInteger length = data.length;
    
    switch (type) {
        case YYImageTypePNG:
        {
            if (length < 23)    return CGSizeZero;
            uint32_t temp_w, temp_h, width, height;
            [data getBytes:&temp_w range:NSMakeRange(16, 4)];
            width = swap_data_uint32(temp_w);
            [data getBytes:&temp_h range:NSMakeRange(16+4, 4)];
            height = swap_data_uint32(temp_h);
            return CGSizeMake(width, height);
            
            
        }
        case YYImageTypeGIF:
        {
            if (length < 10)    return CGSizeZero;
            uint16_t temp_w, temp_h;
            [data getBytes:&temp_w range:NSMakeRange(6, 2)];
            [data getBytes:&temp_h range:NSMakeRange(6+2, 2)];
            return CGSizeMake(temp_w, temp_h);
        }
        case YYImageTypeJPEG:
        {
            CGSize size = CGSizeZero;
            if ([data length] <= 0x58) {
                return size;
            }
            uint16_t temp_w, temp_h, width, height = 0;
            if ([data length] < 210) {// 肯定只有一个DQT字段
                
                [data getBytes:&temp_w range:NSMakeRange(0x60, 2)];
                width = swap_data_uint16(temp_w);
                [data getBytes:&temp_h range:NSMakeRange(0x5e, 2)];
                height = swap_data_uint16(temp_h);
                size = CGSizeMake(width, height);
                
            } else {
                short word = 0x0;
                [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
                if (word == 0xdb) {
                    [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
                    if (word == 0xdb) {// 两个DQT字段
                        [data getBytes:&temp_w range:NSMakeRange(0xa5, 2)];
                        width = swap_data_uint16(temp_w);
                        [data getBytes:&temp_h range:NSMakeRange(0xa3, 2)];
                        height = swap_data_uint16(temp_h);
                        size = CGSizeMake(width, height);
                        
                    } else {// 一个DQT字段
                        [data getBytes:&temp_w range:NSMakeRange(0x60, 2)];
                        width = swap_data_uint16(temp_w);
                        [data getBytes:&temp_h range:NSMakeRange(0x5e, 2)];
                        height = swap_data_uint16(temp_h);
                        size = CGSizeMake(width, height);
                        
                    }
                }
            }
            return size;
        }
        default:
            return CGSizeZero;
    }
}



@end
