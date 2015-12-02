//
//  NetworkRequest.h
//  maQueSheQu
//
//  Created by 薛泽军 on 15/6/12.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkRequest : NSObject
@property (strong,nonatomic)AFHTTPRequestOperationManager *manager;


+ (NetworkRequest*)sharedNetworkRequest;
- (void)postWithUrl:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject,int code))success failure:(void(^)(NSError *error))failure;
- (void)getWithUrl:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
- (void)postFromDataWith:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure WithImage:(id)ImageData;
- (NSDictionary *)userTokenDict;
- (NSMutableDictionary *)userInformation;
-(NSString *)baseTimeString:(NSString *)timeString;
- (void)PreservationUserInformation:(NSDictionary *)dict;
- (void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message;
-(NSString *)getXingzuo:(NSDate *)in_date;
@end
