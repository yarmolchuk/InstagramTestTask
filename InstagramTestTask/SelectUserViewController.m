//
//  SelectUserViewController.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "SelectUserViewController.h"
#import "UserSelectTableViewCell.h"

@interface SelectUserViewController () {
    
    __block InstaUser *selecthUser;
}

@property (weak, nonatomic) IBOutlet UITableView *usersTable;

@end

@implementation SelectUserViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSelectTableViewCell *cell = [self.usersTable dequeueReusableCellWithIdentifier:@"UserSelectTableViewCell"];
    
    InstaUser *user = [self.arrUsers objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL), ^{
        
        NSURL* imgURL = [NSURL URLWithString:user.profile_picture];
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.pic.image = image;
            
            CALayer *layer = [cell.pic layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:cell.pic.frame.size.width/2];
            [layer setBorderWidth:1.0];
            [layer setBorderColor:[[UIColor whiteColor] CGColor]];
        });
    });
    
    cell.name.text = user.username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showProgress];
        
    selecthUser = [self.arrUsers objectAtIndex:indexPath.row];
    
    [[RequestManager sharedInstance] getUserWithName:selecthUser.uidUser andCompletionBlock:^(NSArray *users) {
        
        idSearchUser = selecthUser.uidUser;
        
        [self loadingUserPhoto];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
}


@end
