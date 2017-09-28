//
//  TitleLoadingView.m
//  myJanDan
//
//  Created by mervin on 2017/9/27.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "TitleLoadingView.h"

#define loadingViewMarginRight  3

@interface TitleLoadingView ()

@property(nonatomic, assign) CGSize titleLabelSize;

@end

@implementation TitleLoadingView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        _loadingViewStyle = UIActivityIndicatorViewStyleWhite;
        _loadingViewSize = CGSizeMake(18, 18);
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_loadingViewStyle];
        _loadingView.size = self.loadingViewSize;
        _loadingView.hidesWhenStopped = NO;
        [self addSubview:_loadingView];
        
        self.title = @"Loading...";
        self.tintColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark - layout

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = [self contentSize];
    return resultSize;
}

- (void)layoutSubviews {
    if (CGSizeIsEmpty(self.bounds.size))    return;
    [super layoutSubviews];
    
    CGSize maxSize = self.bounds.size;
    CGSize contentSize = [self contentSize];
    
    self.loadingView.frame = CGRectSetCenterY(self.loadingView.frame, contentSize.height * 0.5);
    CGFloat titleX = self.loadingView.right + loadingViewMarginRight;
    self.titleLabel.frame = CGRectMake(titleX, 0, maxSize.width - titleX, self.titleLabelSize.height);

    [self.loadingView startAnimating];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    UIColor *color = self.tintColor;
    self.titleLabel.textColor = color;
    self.loadingView.color = color;
}

- (void)updateTitleLabelSize {
    if (self.titleLabel.text.length > 0) {
        self.titleLabelSize = CGSizeCeil([self.titleLabel sizeThatFits:CGSizeMax]);
    } else {
        self.titleLabelSize = CGSizeZero;
    }
}

- (CGSize)contentSize {
    CGSize size = CGSizeZero;
    size.width = self.loadingViewSize.width + self.titleLabelSize.width + loadingViewMarginRight;
    size.height = fmax(self.loadingViewSize.height, self.titleLabelSize.height);
    return size;
}

#pragma mark - set/get
- (void)setTitle:(NSString *)title {
    if (_title == title) return;
    _title = title ? : @"Loading...";
    self.titleLabel.text = _title;
    [self updateTitleLabelSize];
    [self setNeedsLayout];
}

- (void)setLoadingViewStyle:(UIActivityIndicatorViewStyle)loadingViewStyle {
    if (_loadingViewStyle == loadingViewStyle) return;
    _loadingViewStyle = loadingViewStyle;
    self.loadingViewStyle = _loadingViewStyle;
    [self setNeedsLayout];
}

- (void)setLoadingViewSize:(CGSize)loadingViewSize {
    
}

@end
