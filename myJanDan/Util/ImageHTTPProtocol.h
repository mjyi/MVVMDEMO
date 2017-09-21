//
//  ImageHTTPProtocol.h
//  myJanDan
//
//  Created by mervin on 2017/9/20.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageHTTPProtocol : NSURLProtocol

@end

FOUNDATION_STATIC_INLINE NSString* contentTypeForImageData(NSData *data);
