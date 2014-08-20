//
//  ShowCollageViewController.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "ShowCollageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+CBFrameHelpers.h"
#import "MediaUser.h"

@interface ShowCollageViewController () {
    
    NSMutableArray *urls;
    NSMutableArray *images;
}

@property (weak, nonatomic) IBOutlet UIView *viewCollage;
@property (weak, nonatomic) IBOutlet UIButton *btnPrint;

- (IBAction)actPrintImage:(id)sender;

@end

@implementation ShowCollageViewController

- (NSArray *)urls
{
    if (!urls) {
        urls = [NSMutableArray array];
    }
    
    return urls;
}

- (NSArray *)filteredContacts
{
    if (!images) {
        images = [NSMutableArray array];
    }
    
    return images;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        images = [NSMutableArray array];
        urls = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showProgress];
    
    for (MediaUser * obj in self.arrShowImg) {
        [urls addObject:obj.imgStandart.urlImage];
    }
    
    __block int count = 0;
    
    for (NSString *url in urls) {
        
        if([[NSUserDefaults standardUserDefaults] valueForKey:url]){
            
            count++;
            
            if(count == [urls count]) {
                [self addAllImagesOnView];
            }
        }
        else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                
                NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                [[NSUserDefaults standardUserDefaults] setValue:imageData forKey:url];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                dispatch_async(dispatch_get_main_queue(),^{
                    count++;
                    
                    if(count == [urls count]) {
                        [self addAllImagesOnView];
                    }
                });
            });
        }
    }
}

#pragma mark -action

- (IBAction)actPrintImage:(id)sender
{
    [self printPhotoWithImage:[self imageWithView:self.viewCollage]];
}

-(void)printPhotoWithImage:(UIImage *)image
{
    NSData *myData = UIImageJPEGRepresentation(image, 1.f); UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    if (pic && [UIPrintInteractionController canPrintData:myData]) {
        
        pic.delegate = self;
        UIPrintInfo *pinfo = [UIPrintInfo printInfo];
        pinfo.outputType = UIPrintInfoOutputPhoto;
        pinfo.jobName = @"My collage";
        pinfo.duplex = UIPrintInfoDuplexLongEdge;
        
        pic.printInfo = pinfo;
        pic.showsPageRange = YES;
        pic.printingItem = myData;
        
        pic.printFormatter = normal;
        
        void(^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *print, BOOL completed, NSError *error) {
            
            [self resignFirstResponder];
            
            if (!completed && error) {
                NSLog(@"--- print error! ---");
            }
        };
        
        [pic presentFromRect:CGRectMake((self.view.bounds.size.width - 64) + 27, (self.view.bounds.size.height - 16) + 55, 0, 0) inView:self.view animated:YES completionHandler:completionHandler];
    }
}

-(void)addAllImagesOnView
{
    [self hideProgress];
    
    for (NSString *strUrl in urls) {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:strUrl];
        UIImage *img = [UIImage imageWithData:data];
        
        [images addObject:img];
    }
    
    int count = (int)ceilf(sqrtf([self.arrShowImg count]));
    int numberX = (int)320/count;
    int numberY = (int)320/count;
    
    int col = 0;
    int row = 0;
    int maxCol = 0;
    
    for (UIImage *img in images) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        
        [self.viewCollage addSubview:imgView];
        
        if(row<count){
            [imgView setX:col*numberX andY:row*numberY];
            [imgView setW:numberX andH:numberY];
            
            col++;
            maxCol = MAX(maxCol, col);
            
            if(col >= count) {
                row++;
                col = 0;
            }
        }
    }
    
    if(col && col < maxCol) {
        float width = 320 / col;
        
        for (int i = 0; i < col; i++) {
            UIImageView *imgView = [[self.viewCollage subviews] objectAtIndex:[[self.viewCollage subviews] count] - i - 1];
            [imgView setW:width];
            [imgView setX:width*i];
            
            imgView.image = [self croppIngimageByImageName:imgView.image toRect:imgView.frame];
        }
    }
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
