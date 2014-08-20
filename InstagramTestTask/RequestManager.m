//
//  RequestManager.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "RequestManager.h"
#import "RKObjectRequestOperation.h"

#import "InstaUser.h"
#import "MediaUser.h"

#define BASE_URL                                        @"https://api.instagram.com"

#define kInstagramApiBaseUrl                            @"/v1"
#define kInstagramApiBaseUrlComplete                    @"https://api.instagram.com/v1"

#define kAccessTokenKey                                 @"access_token"

static RequestManager* instanse = nil;

static NSString* access_token;
static NSString* client_id;
static NSString* client_secret;
static NSString* callback_url;

@implementation RequestManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instanse = [[RequestManager alloc] init];
    });
    
    return instanse;
}

+(void)initialize
{
    access_token = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessTokenKey];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"InstagramConfigs" ofType:@"plist"];
    NSDictionary* configs = [[NSDictionary alloc]initWithContentsOfFile:path];

    callback_url = configs[@"InstagramClientCallbackURL"];
    client_id = configs[@"InstagramClientId"];
    client_secret = configs[@"InstagramClientSecret"];
}

- (void)getUserWithName:(NSString *)name andCompletionBlock:(void(^)(NSArray *users))block
{
    NSString* currentParam = @"client_id";
    NSString* currentParamValue  = client_id;
    
    block = [block copy];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@/%@/%@?q=%@&%@=%@&count=%d", BASE_URL, kInstagramApiBaseUrl, @"users", @"search", name, currentParam, currentParamValue, 20];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[InstaUser mapObject] method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        NSMutableArray *arrUsers = [[NSMutableArray alloc] init];
        
        for (InstaUser *item in [result array]) {
            [arrUsers addObject:item];
        }
        
        block(arrUsers);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        block(nil);
    }];
    
    [operation start];
}


- (void)getMediaRecentInUserWithId:(NSString*)Id count:(int)count minId:(NSString*)minId maxId:(NSString*)maxId minTimestamp:(NSDate*)minTimestamp maxTimestamp:(NSDate*)maxTimestamp andCompletionBlock:(void(^)(NSArray *photos))block
{
    
    NSString* currentParam = @"client_id";
    NSString* currentParamValue = client_id;
    
    NSString* countParam = count > 0 ? [NSString stringWithFormat:@"&count=%d", count] : @"";
    
    NSString* earlierParam = maxTimestamp!=nil?[NSString stringWithFormat:@"&max_timestamp=%d",(int)[maxTimestamp timeIntervalSince1970]]:@"";
    NSString* laterParam = minTimestamp!=nil?[NSString stringWithFormat:@"&min_timestamp=%d",(int)[minTimestamp timeIntervalSince1970]]:@"";
    
    
    NSString* minIdParam = minId!=nil?[NSString stringWithFormat:@"&min_id=%@",minId]:@"";
    NSString* maxIdParam = maxId!=nil?[NSString stringWithFormat:@"&max_id=%@",maxId]:@"";
    
    NSString* strUrl = [NSString stringWithFormat:@"%@%@/%@/%@/%@?%@=%@%@%@%@%@%@",BASE_URL, kInstagramApiBaseUrl,@"users",Id,@"media/recent",currentParam,currentParamValue,countParam,earlierParam,laterParam,minIdParam,maxIdParam];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MediaUser mapObject] method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:nil];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        NSMutableArray *arrMediaUser = [[NSMutableArray alloc] init];
        
        for (MediaUser *item in [result array]) {
            [arrMediaUser addObject:item];
        }
        
        block(arrMediaUser);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        block(nil);
    }];
    
    [operation start];

}


@end
