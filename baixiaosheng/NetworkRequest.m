//
//  NetworkRequest.m
//  maQueSheQu
//
//  Created by 薛泽军 on 15/6/12.
//  Copyright (c) 2015年 薛泽军. All rights reserved.

#import "NetworkRequest.h"
#import "AFNetworking.h"
//#import "GiFHUD.h"

@implementation NetworkRequest
{
    MLProgressHUD *_mph;
}
+ (NetworkRequest*)sharedNetworkRequest;
{
    static NetworkRequest *sharedNRT;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedNRT = [[self alloc] init];
//    });
    if (sharedNRT==nil) {
        sharedNRT = [[self alloc] init];
//        [GiFHUD setGifWithImageName:@"xn02.gif"];
    }
    return sharedNRT;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager =[AFHTTPRequestOperationManager manager];
    }
    return self;
}
- (void)postWithUrl:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject,int code))success failure:(void(^)(NSError *error))failure;
{
    _mph=[[MLProgressHUD alloc]initWithMessage:@"加载中"];
    [self.manager POST:urlString parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_mph dismiss];
        success(responseObject,[responseObject[@"code"] intValue]);
        if ([responseObject[@"code"] intValue]!=1) {
            [[NetworkRequest sharedNetworkRequest] alertViewWithTitle:@"温馨提示" andMessage:responseObject[@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_mph dismiss];
        UIAlertView *alv=[[UIAlertView alloc]initWithTitle:@"网络错误" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alv show];
        NSLog(@"%@",error);
        failure(error);
    }];
}
- (void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message;
{
    UIAlertView *alv=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alv show];
}
- (void)getWithUrl:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
{
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [self.manager GET:urlString parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
- (void)postFromDataWith:(NSString *)urlString andParData:(id)data success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure WithImage:(id)ImageData;
{
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
      //  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
      //  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString* fileName = [NSString stringWithFormat:@"%d.png",arc4random()%9999999+arc4random()%999999];
        [formData appendPartWithFileData:ImageData name:@"Filedata" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
- (void)PreservationUserInformation:(NSDictionary *)dict;
{
    if (dict==nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFORMATION];
        return;
    }
    NSMutableDictionary *userDicr=[NSMutableDictionary dictionary];
    for (NSString *keys in [dict allKeys]) {
        if ([dict[keys] isKindOfClass:[NSNull class]]) {
            [userDicr setValue:@"" forKey:keys];
        }else
        {
            [userDicr setValue:dict[keys] forKey:keys];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:userDicr forKey:USERINFORMATION];
//    [[NSUserDefaults standardUserDefaults] setValue:dict[@"token"] forKey:USERTOKEN]; 
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSDictionary *)userTokenDict;
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFORMATION] objectForKey:@"token"],@"token",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFORMATION] objectForKey:@"uid"],@"uid", nil];
    return dict;
}
- (NSMutableDictionary *)userInformation;
{
    NSMutableDictionary *userinformation=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFORMATION]];
    return userinformation;
}
-(NSString *)baseTimeString:(NSString *)timeString;
{
    if ([timeString isKindOfClass:[NSNull class]]) {
        timeString=@"0";
    }
    NSTimeInterval time=[timeString intValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:date];
    return dateString;
}
-(NSString *)getXingzuo:(NSDate *)in_date
{
    //计算星座
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:in_date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:in_date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}

@end
