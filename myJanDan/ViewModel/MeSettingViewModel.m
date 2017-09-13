//
//  MeSettingViewModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/29.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "MeSettingViewModel.h"
#import "SettingsHelper.h"

@interface MeSettingViewModel ()

@property(nonatomic, copy, readwrite) NSString *cacheString;

@end

@implementation MeSettingViewModel

- (void)initialize {
    self.title = @"设置";
//    @weakify(self)
//    self.loadSettingsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        @strongify(self)
//        self.cacheString = [self cacheString];
//        return nil;
//    }];

}

- (NSString *)cacheString {
    NSInteger totalCost = [SettingsHelper imageCacheCost];
    CGFloat cacheSize = totalCost/1024.0f/1024.0f;
    return [NSString stringWithFormat:@"%.2f M", cacheSize];
}

@end
