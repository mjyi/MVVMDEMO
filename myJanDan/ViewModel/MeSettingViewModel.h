//
//  MeSettingViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/29.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "TableViewModel.h"

@interface MeSettingViewModel : TableViewModel

@property(nonatomic, strong) NSArray *events;

@property(nonatomic, copy, readonly) NSString *cacheString;

@property(nonatomic, strong) RACCommand *loadSettingsCommand;

@end
