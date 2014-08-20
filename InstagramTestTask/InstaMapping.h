//
//  InstaMapping.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKObjectRequestOperation.h"

@protocol InstaMapping <NSObject>

@required

+ (RKObjectMapping *)mapObject;

@end
