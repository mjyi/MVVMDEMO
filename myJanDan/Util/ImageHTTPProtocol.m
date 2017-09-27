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
#define protocolHost    [ImageHTTPProtocol netHost]

static NSString* const FilteredKey = @"FilteredKey";
static char imageProtocolRequestKey;

@interface ImageHTTPProtocol ()

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
    if (imageData) {
        NSURLResponse *rsp = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                       MIMEType:contentTypeForImageData(imageData)
                                          expectedContentLength:imageData.length
                                               textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:rsp cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:imageData];
        [self.client URLProtocolDidFinishLoading:self];
    }
    
    self.imageRequest = [protocolHost requestWithURLString:request.URL.absoluteString];
    self.imageRequest.request.timeoutInterval = 15;
    @weakify(self)
    [self.imageRequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        @strongify(self)
        if (completedRequest.error) {
            [self.client URLProtocol:self didFailWithError:completedRequest.error];
        } else {
            NSData *data = completedRequest.responseData;
            YYImage *image = [YYImage imageWithData:data];
            [imageCache setValue:image forKey:completedRequest.request.URL.absoluteString];
            [self.client URLProtocol:self didReceiveResponse:completedRequest.response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
            [self.client URLProtocol:self didLoadData:data];
            [self.client URLProtocolDidFinishLoading:self];
        }
    }];
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

@end

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

