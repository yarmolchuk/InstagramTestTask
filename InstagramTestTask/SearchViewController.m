//
//  ViewController.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 18.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "SearchViewController.h"
#import "SelectUserViewController.h"

#import "MediaUser.h"


@interface SearchViewController () {
    
    __block NSArray *arrSelectUser;
    __block NSNumber *media_count;
    __block NSString *maxPhotoId;
}

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnComeCollage;

- (IBAction)actComeCollage:(id)sender;

@end

@implementation SearchViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    
        allPhotos = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)actComeCollage:(id)sender
{
    [self.view endEditing:YES];
    
    if (!self.tfUserName.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"Введите ник пользователя" message:@"Что бы создать коллаж с фотографий пользователя, Вам необходимо ввести ник пользователя!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    
    [self showProgress];
    [[RequestManager sharedInstance] userWithName:self.tfUserName.text andCompletionBlock:^(NSArray *users) {
       
        if (users.count > 1) {
            
            arrSelectUser = [NSArray arrayWithArray:users];
            
            [self performSegueWithIdentifier:@"selectUser" sender:self];
        }
        else {
        
            InstaUser *user = [users lastObject];
            idSearchUser = user.uidUser;
            
            [self loadingUserPhoto];
        }
    }];
}

- (void)loadingUserPhoto
{
    [[RequestManager sharedInstance] mediaRecentInUserWithId:idSearchUser count:20 minId:@"" maxId:maxPhotoId minTimestamp:nil maxTimestamp:nil andCompletionBlock:^(NSArray *photos) {
        
        if (photos.count) {
            
            MediaUser *image = [photos lastObject];
            maxPhotoId = image.contentId;
            
            [allPhotos addObjectsFromArray:photos];
            [self performSelector:@selector(loadingUserPhoto) withObject:nil afterDelay:0];
        }
        else {
        
            if (!allPhotos.count) {
                
                [[[UIAlertView alloc] initWithTitle:@"Нет фото!!!" message:@"У данного пользователя нет фотографий для создания коллажа!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                [self hideProgress];
                return;
                
            } else {
                
                [allPhotos sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    MediaUser* img1 = obj1;
                    MediaUser* img2 = obj2;
                    
                    return [[NSNumber numberWithInt: img2.likes] compare:[NSNumber numberWithInt: img1.likes]];
                }];
                
                [self performSegueWithIdentifier:@"showCollage" sender:self];
            }
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self hideProgress];
    
    if ([[segue identifier] isEqualToString:@"showCollage"]) {
        
        ShowCollageViewController *vc = (ShowCollageViewController *)[segue destinationViewController];
        
        if (allPhotos.count < 8) {
            vc.arrShowImg = [allPhotos subarrayWithRange:NSMakeRange(0, allPhotos.count)];
        }
        else {
            vc.arrShowImg = [allPhotos subarrayWithRange:NSMakeRange(0, 8)];
        }
    }
    else if ([[segue identifier] isEqualToString:@"selectUser"]) {
        
        SelectUserViewController *vc = (SelectUserViewController *)[segue destinationViewController];
        vc.arrUsers = arrSelectUser;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
