//
//  MediaUser.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "MediaUser.h"
#import "RKObjectMapping.h"
#import "RKRelationshipMapping.h"

@interface MediaUser () <InstaMapping>

@end

@implementation MediaUser

+(RKObjectMapping *)mapObject
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"likes.count": @"likes",
                                                  @"id":@"contentId"
                                                  }];
    
    NSDictionary *dic = @{@"images.low_resolution" : @"imgLow", @"images.standard_resolution" : @"imgStandart", @"images.thumbnail" : @"imgThumbnail"};

    for (NSString *key in [dic allKeys]) {
        [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:key
                                                                                toKeyPath:[dic objectForKey:key]
                                                                              withMapping:[ImageObject mapObject]]];
    }
    
    return mapping;
}

@end
