//
//  PicModel.m
//  myJanDan
//
//  Created by mervin on 2017/8/21.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "PicModel.h"

@interface PicModel ()

@property(nonatomic, assign, readwrite) CGFloat height;

@end


@implementation PicModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSArray *pics = dic[@"pics"];
    _pics = @[].mutableCopy;
    for (NSString *pic in pics) {
        PictureMeta *meta = [[PictureMeta alloc] init];
        meta.url = pic;
        [_pics addObject:meta];
    }
    NSString *text_content = dic[@"text_content"];
    NSString *temp = [text_content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _text_content = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (![object isMemberOfClass:self.class]) return NO;
    PicModel *pic = (PicModel *)object;
    return [self.comment_ID isEqualToString:pic.comment_ID];
    
}

- (CGFloat)height {
    if (_height > 0) return _height;
    
    CGFloat height = 38.0;
    CGFloat picHeight, textHeight = 0;
    // 获取图片高度
    if (self.pics.count) {
        PictureMeta *meta = self.pics[0];
        
        if (meta.width > 0 && meta.height/meta.width > 2)  meta.badgeType = PicBadgeTypeLong;
        
        if (PicBadgeTypeLong == meta.badgeType) {
            picHeight = kScreen_Height - 100;
        } else {
            picHeight = meta.height > 0 ? ((float)meta.height/meta.width * kScreenWidth): kScreen_Width * 0.68;
        }
        height += picHeight;
    }
    // 计算字体高度
    textHeight = [self.text_content heightForFont:FontOfSize(SizeT2)
                                            width:(kScreen_Width-16)];
    height += textHeight;
    _height = ceil(height);
    return _height;
}

#pragma mark - Protocol
-(NSString *)date {
    return _comment_date;
}

@end

@implementation PictureMeta

@end
