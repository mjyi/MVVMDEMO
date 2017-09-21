//
//  JUIHelper.h
//  myJanDan
//
//  Created by mervin on 2017/9/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JUIHelper : NSObject

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end
