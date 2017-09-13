//
//  SettingsHelper.h
//  myJanDan
//
//  Created by mervin on 2017/8/31.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsHelper : NSObject

+ (NSInteger)imageCacheCost;

+ (void)cleanDefaultImageCacheOnDisk:(void(^)(int removedCount, int totalCount))progress
                            endBlock:(void(^)(BOOL error))end;

+ (void)autoRemoveCost;

@end
