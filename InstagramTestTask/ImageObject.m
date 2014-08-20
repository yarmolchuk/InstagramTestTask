//
//  ImageObject.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "ImageObject.h"

@interface ImageObject () <InstaMapping>

@end

@implementation ImageObject

+ (RKObjectMapping *)mapObject
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"width": @"widthImage",
                                                  @"height": @"heightImage",
                                                  @"url": @"urlImage"
                                                  }];
    return mapping;
}

@end
