//
//  HomeTableCell.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/2.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "HomeTableCell.h"
@implementation HomeTableCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setTitleText:(NSString *)titleText;
{
    NSLog(@"title~~%@",titleText);
    self.titleLable.text=titleText;
    CGRect frome=self.imageBtu.frame;
    frome.origin.x=(WIDTH(self)-[self boundingRectWithSize:self.titleLable.frame.size WithFont:self.titleLable.font WithText:titleText].width-22)/2;
    self.imageBtu.frame=frome;
    CGRect tfrome=self.titleLable.frame;
    tfrome.origin.x=frome.origin.x+22;
    tfrome.size.width=[self boundingRectWithSize:self.titleLable.frame.size WithFont:self.titleLable.font WithText:titleText].width;
    self.titleLable.frame=tfrome;
    self.lineLable.frame=CGRectMake(WIDTH(self),Y(self.lineLable),WIDTH(self.lineLable),HEIGHT(self.lineLable));
}
- (CGSize)boundingRectWithSize:(CGSize)size WithFont:(UIFont *)font WithText:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}
@end
