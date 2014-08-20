//
//  InstaUser.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKResponseDescriptor.h"
#import "InstaMapping.h"

@interface InstaUser : NSObject

@property (nonatomic, copy) NSString *uidUser;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *website;
@property (nonatomic, copy) NSString *profile_picture;
@property (nonatomic, copy) NSString *full_name;

+ (RKObjectMapping *)mapObject;

@end
