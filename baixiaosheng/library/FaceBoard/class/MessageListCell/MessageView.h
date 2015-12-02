//
//  MessageView.h
//  FaceBoardDome
//
//  Created by kangle1208 on 13-12-12.
//  Copyright (c) 2013年 Blue. All rights reserved.
//


#import <UIKit/UIKit.h>


#define KFacialSizeWidth    22

#define KFacialSizeHeight   22

#define KCharacterWidth     8


#define VIEW_LINE_HEIGHT    KFacialSizeWidth+4

#define VIEW_LEFT           16

#define VIEW_RIGHT          16

#define VIEW_TOP            8


#define VIEW_WIDTH_MAX      WIDTH(WINDOW)-(320-167)


@interface MessageView : UIView {

    
    CGFloat upX;

    CGFloat upY;

    CGFloat lastPlusSize;

    CGFloat viewWidth;

    CGFloat viewHeight;

    BOOL isLineReturn;
}


@property (nonatomic, assign) NSMutableArray *data;


- (void)showMessage:(NSArray *)message;


@end
