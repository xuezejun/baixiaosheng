//
//  NSStringAdditions.h
//  Singapore
//
//  Created by 薛泽军 on 15/4/17.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSStringAdditions:NSObject

+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;
- (NSString *) base64StringWithHMACSHA1Digest:(NSString *)secretKey;
@end
