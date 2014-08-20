//
//  ImageObject.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKResponseDescriptor.h"
#import "InstaMapping.h"

@interface ImageObject :  NSObject <InstaMapping>

@property (nonatomic, assign) float widthImage;
@property (nonatomic, assign) float heightImage;
@property (nonatomic, copy) NSString *urlImage;

+(RKObjectMapping *)mapObject;

@end
