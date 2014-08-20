//
//  ViewController.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 18.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "RequestManager.h"
#import "InstaUser.h"
#import "ShowCollageViewController.h"

@interface SearchViewController : SuperViewController {
    
    __block NSString *idSearchUser;
    __block NSMutableArray *allPhotos;
}

- (void)loadingUserPhoto;

@end
