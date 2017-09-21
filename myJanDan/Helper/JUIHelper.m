//
//  JUIHelper.m
//  myJanDan
//
//  Created by mervin on 2017/9/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "JUIHelper.h"

@implementation JUIHelper

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title
                                image:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                                  tag:(NSInteger)tag
{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    return tabBarItem;
}

@end
