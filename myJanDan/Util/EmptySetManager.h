//
//  EmptySetManager.h
//  myJanDan
//
//  Created by mervin on 2017/9/4.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EmptySetType) {
    EmptySetTypeDefault = 0,
    EmptySetTypeValue1,
    EmptySetTypeError,
    
    
};




@interface EmptySetManager : NSObject



- (void)configWithSCrollView:(UIScrollView *)scrollView
                  controller:(UIViewController *)controller;

@end
