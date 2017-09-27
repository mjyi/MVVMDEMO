//
//  TitleLoadingView.h
//  myJanDan
//
//  Created by mervin on 2017/9/27.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleLoadingView : UIView

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIActivityIndicatorView *loadingView;

// configuration
@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIFont *titleFont;

@property(nonatomic, assign) UIActivityIndicatorViewStyle loadingViewStyle;
@property(nonatomic, assign) CGSize loadingViewSize;

@end
