//
//  Pic_Cell.m
//  myJanDan
//
//  Created by mervin on 2017/8/23.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "Pic_Cell.h"
#import "NSString+Addition.h"
#import "UIView+Common.h"

#define kCellPadding        15  //内边距
#define kCellPaddingText    6   // 文本行间距
#define kCellLineSpacing    12  //行间距
#define kCellBottomHeight   30  // 底部xx、oo的高度

@interface Pic_Cell ()

@property (nonatomic, weak) IBOutlet YYAnimatedImageView *animatedImageView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ooLabel;
@property (weak, nonatomic) IBOutlet UILabel *xxLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, weak) YYWebImageOperation *imageDownloadOperation;

@end

@implementation Pic_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    

    return self;
}

- (void) setLayout:(PicModel *)pic {
    _dateLabel.text = [pic.date transformToFuzzyDate];
    
    NSString *oo = [self configType:@"OO" count:pic.vote_positive];
    NSMutableAttributedString *ooString = [[NSMutableAttributedString alloc] initWithString:oo];
    [ooString addAttributes:@{
                              NSForegroundColorAttributeName:kColorOO,
                              NSFontAttributeName: BoldFontOfSize(SizeT4)
                              }
                      range:NSMakeRange(0, 2)];
    _ooLabel.attributedText = ooString;
    
    NSString *xx = [self configType:@"XX" count:pic.vote_negative];
    NSMutableAttributedString *xxString = [[NSMutableAttributedString alloc] initWithString:xx];
    [ooString addAttributes:@{
                              NSForegroundColorAttributeName:kColorOO,
                              NSFontAttributeName: BoldFontOfSize(SizeT4)
                              } range: NSMakeRange(0, 2)];
    _xxLabel.attributedText = xxString;
    _commentLabel.text = [self configType:@"吐槽" count:pic.sub_comment_count];
    
    self.contentLabel.text = pic.text_content;
    
    PictureMeta *meta = pic.pics.count>0 ? pic.pics[0]: nil;
    
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.animatedImageView
     setImageWithURL:[NSURL URLWithString:meta.url]
     placeholder:nil
     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation
     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//         DebugLog(@" %@\n  %ld / %ld", meta.url, receivedSize, expectedSize);
         [self.animatedImageView showPropress:(receivedSize/(float)expectedSize)];
     }
     transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
         
         [self.animatedImageView hideProgress];
     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

- (NSString *)configType:(NSString *)type count:(NSString *)count {
    return [NSString stringWithFormat:@"%@[%@]",type, count];
}

@end
