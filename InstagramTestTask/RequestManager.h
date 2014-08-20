//
//  RequestManager.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (instancetype)sharedInstance;

- (void)getUserWithName:(NSString *)user andCompletionBlock:(void(^)(NSArray *users))block;

- (void)getMediaRecentInUserWithId:(NSString*)Id count:(int)count minId:(NSString*)minId maxId:(NSString*)maxId minTimestamp:(NSDate*)minTimestamp maxTimestamp:(NSDate*)maxTimestamp andCompletionBlock:(void(^)(NSArray *photos))block;

@end
