//
//  BaiXiaoShengStandard.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/10/10.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "BaiXiaoShengStandard.h"

@implementation BaiXiaoShengStandard
BaiXiaoShengStandard *_baixiaoStandard;
+(BaiXiaoShengStandard *)baiXiaostandard;
{
    if (_baixiaoStandard==nil) {
        _baixiaoStandard=[[BaiXiaoShengStandard alloc]init];
    }
    return _baixiaoStandard;
}

@end
