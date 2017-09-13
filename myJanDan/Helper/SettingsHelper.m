//
//  SettingsHelper.m
//  myJanDan
//
//  Created by mervin on 2017/8/31.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "SettingsHelper.h"

@implementation SettingsHelper

// bytes
+ (NSInteger)imageCacheCost {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    // 获取缓存大小
//    cache.memoryCache.totalCost;
//    cache.memoryCache.totalCount;
//    cache.diskCache.totalCount;
    // 清空缓存
//    [cache.memoryCache removeAllObjects];
//    [cache.diskCache removeAllObjects];
    NSInteger cost = cache.diskCache.totalCost;
    return cost;
}

+ (void)cleanDefaultImageCacheOnDisk:(void (^)(int, int))progress endBlock:(void (^)(BOOL))end {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    // 清空磁盘缓存，带进度回调
    [cache.diskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

// 100 M
+ (void)autoRemoveCost {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.diskCache trimToCost:100 * 1024 * 1024];
}

@end
