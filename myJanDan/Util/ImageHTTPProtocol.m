//
//  ImageHTTPProtocol.m
//  myJanDan
//
//  Created by mervin on 2017/9/20.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "ImageHTTPProtocol.h"
#import "MKNetworkKit.h"

#define imageCache      [YYWebImageManager sharedManager].cache
#define ProtocolHost    [ImageHTTPProtocol netHost]

static NSString* const FilteredKey = @"FilteredKey";
static char imageProtocolRequestKey;

FOUNDATION_STATIC_INLINE NSString* contentTypeForImageData(NSData *data) {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            return nil;
    }
    return nil;
}


@interface ImageHTTPProtocol ()

@property(nonatomic, strong) MKNetworkRequest *imageRequest;

@end

//将图片使用YYbImageCache缓存
@implementation ImageHTTPProtocol

+ (MKNetworkHost *)netHost {
    static MKNetworkHost *netHost;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netHost = [[MKNetworkHost alloc] init];
        [netHost enableCache];
    });
    return netHost;
}



+ (BOOL)canInitWithRequest:(NSURLRequest *)request {

    NSString *urlString = request.URL.absoluteString;
    NSArray *imgURLs = @[@"jpg", @"png", @"jpeg", @"gif"];
    BOOL isImage = [imgURLs.rac_sequence any:^BOOL(NSString *string) {
        return [urlString rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound;
    }];
    
    return [NSURLProtocol propertyForKey:FilteredKey inRequest:request] == nil && isImage;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    
    NSMutableURLRequest* request = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request];
    
    NSData *imageData = [imageCache getImageDataForKey:self.request.URL.absoluteString];
    
    
    if (YYImageTypeUnknown != YYImageDetectType((__bridge CFDataRef _Nonnull)(imageData))) {
        NSURLResponse *rsp = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                       MIMEType:contentTypeForImageData(imageData)
                                          expectedContentLength:imageData.length
                                               textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:rsp cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:imageData];
        [self.client URLProtocolDidFinishLoading:self];
        return;
    }
    
    self.imageRequest = [ProtocolHost requestWithURLString:request.URL.absoluteString];
    self.imageRequest.request.timeoutInterval = 15;
    @weakify(self)
    [self.imageRequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        @strongify(self)
        if (completedRequest.error) {
            [self.client URLProtocol:self didFailWithError:completedRequest.error];
        } else {
            NSData *data = completedRequest.responseData;
            [imageCache setImage:nil
                       imageData:data
                          forKey:completedRequest.request.URL.absoluteString
                        withType:YYImageCacheTypeAll];
            [self.client URLProtocol:self didReceiveResponse:completedRequest.response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
        }
    }];
    [ProtocolHost startRequest:self.imageRequest];
}

- (void)stopLoading {
    [self.imageRequest cancel];
}

-(MKNetworkRequest*) imageRequest {
    
    return (MKNetworkRequest*) objc_getAssociatedObject(self, &imageProtocolRequestKey);
}

-(void) setImageRequest:(MKNetworkRequest *)imageRequest {
    objc_setAssociatedObject(self,
                             &imageProtocolRequestKey,
                             imageRequest,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - session delegate
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
//    
//    //处理重定向问题
//    if (response != nil) {
//        NSMutableURLRequest *redirectableRequest = [request mutableCopyWorkaround];
//        TURLProtocolCacheData *cacheData = [[TURLProtocolCacheData alloc] init];
//        cacheData.data = self.cacheData;
//        cacheData.response = response;
//        cacheData.redirectRequest = redirectableRequest;
//        [NSKeyedArchiver archiveRootObject:cacheData toFile:[self p_filePathWithUrlString:request.URL.absoluteString]];
//        
//        [self.client URLProtocol:self wasRedirectedToRequest:redirectableRequest redirectResponse:response];
//        completionHandler(request);
//        
//    } else {
//        
//        completionHandler(request);
//    }
//}
//
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
//    
//    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
//    // 允许处理服务器的响应，才会继续接收服务器返回的数据
//    completionHandler(NSURLSessionResponseAllow);
//    self.cacheData = [NSMutableData data];
//    self.response = response;
//}
//
//-  (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
//    //下载过程中
//    [self.client URLProtocol:self didLoadData:data];
//    [self.cacheData appendData:data];
//    
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//    //    下载完成之后的处理
//    
//    if (error) {
//        NSLog(@"error url = %@",task.currentRequest.URL.absoluteString);
//        [self.client URLProtocol:self didFailWithError:error];
//    } else {
//        //将数据的缓存归档存入到本地文件中
//        NSLog(@"ok url = %@",task.currentRequest.URL.absoluteString);
//        TURLProtocolCacheData *cacheData = [[TURLProtocolCacheData alloc] init];
//        cacheData.data = [self.cacheData copy];
//        cacheData.addDate = [NSDate date];
//        cacheData.response = self.response;
//        [NSKeyedArchiver archiveRootObject:cacheData toFile:[self p_filePathWithUrlString:self.request.URL.absoluteString]];
//        [self.client URLProtocolDidFinishLoading:self];
//    }
//}


@end
