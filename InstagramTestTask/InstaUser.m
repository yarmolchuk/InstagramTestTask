//
//  InstaUser.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "InstaUser.h"
#import "RKObjectMapping.h"

@implementation InstaUser


+(RKObjectMapping *)mapObject
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"username": @"username",
                                                  @"bio": @"bio",
                                                  @"website": @"website",
                                                  @"profile_picture": @"profile_picture",
                                                  @"full_name": @"full_name",
                                                  @"id": @"uidUser"
                                                  }];
    return mapping;
}

@end

