//
//  SettingCellViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/31.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JDViewModel.h"


@interface SettingCellViewModel : JDViewModel

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *avaterURL;

@property(nonatomic, strong) RACCommand *didSelectCommand;

@end
