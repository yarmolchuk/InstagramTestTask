//
//  SuperViewController.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "SuperViewController.h"
#import "SpinnerView.h"

@interface SuperViewController ()

@property (nonatomic, retain) SpinnerView *progressIndicatorView;

@end

@implementation SuperViewController


- (void)showProgress
{
	if (self.progressIndicatorView)
    {
		return;
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	UIView *view = [UIApplication sharedApplication].delegate.window;
    
    SpinnerView *progView = [SpinnerView spinerViewWithFrame:view.bounds];
    self.progressIndicatorView = progView;
    
	progView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
	CGRect labFrame = {0};
	labFrame.size.width = progView.bounds.size.width - 20;
	labFrame.size.height = 24;
	
	[view addSubview:progView];
    [self.progressIndicatorView startAnimation];
}

- (void)hideProgress
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
    if (self.progressIndicatorView)
    {
		[self.progressIndicatorView removeFromSuperview];
		self.progressIndicatorView = nil;
	}
}


@end
