//
//  MediaUser.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKResponseDescriptor.h"
#import "InstaMapping.h"
#import "ImageObject.h"

@interface MediaUser : NSObject 

@property (nonatomic, strong) ImageObject *imgLow;
@property (nonatomic, strong) ImageObject *imgStandart;
@property (nonatomic, strong) ImageObject *imgThumbnail;

@property (nonatomic, copy) NSString *contentId;
@property (nonatomic) NSInteger likes;

+ (RKObjectMapping *)mapObject;


@end

