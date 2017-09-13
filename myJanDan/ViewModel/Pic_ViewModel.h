//
//  Pic_ViewModel.h
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "TableViewModel.h"

typedef NS_ENUM(NSUInteger, PicType) {
    PicTypePIC = 0,     // 无聊图
    PicTypeXXOO,        // 妹子图
    PicTypeJoke,        //段子
};

@interface Pic_ViewModel : TableViewModel

@property (nonatomic, assign)PicType type;

@end
