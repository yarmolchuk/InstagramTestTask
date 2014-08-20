//
//  SpinnerView.h
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

@property (retain, nonatomic) UIImageView *imgViewSpinner;
@property (assign, nonatomic) NSInteger framesPerSecond;

- (void)startAnimation;
- (void)stopAnimation;

+ (SpinnerView *)spinnerView;
+ (SpinnerView *)spinerViewWithFrame:(CGRect)frame;


@end
