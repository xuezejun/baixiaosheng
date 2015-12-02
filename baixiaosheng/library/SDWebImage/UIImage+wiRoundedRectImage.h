//
//  UIImage+wiRoundedRectImage.h
//  maQueSheQu
//
//  Created by 薛泽军 on 15/7/21.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (wiRoundedRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
