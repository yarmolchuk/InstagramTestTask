//
//  SpinnerView.m
//  InstagramTestTask
//
//  Created by Dima Yarmolchuk on 19.07.14.
//  Copyright (c) 2014 Dima Yarmolchuk. All rights reserved.
//

#import "SpinnerView.h"

const int kSpinnerViewTag = 102938;

@implementation SpinnerView

-(NSInteger)framesPerSecond
{
    if (!_framesPerSecond) {
        _framesPerSecond = 40;
    }
    
    return _framesPerSecond;
}

-(UIImageView *)imgViewSpinner
{
    if (!_imgViewSpinner)
    {
        _imgViewSpinner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]];
        [self addSubview:_imgViewSpinner];
        _imgViewSpinner.backgroundColor = [UIColor clearColor];
        CGRect tmpFrame = _imgViewSpinner.frame;
        if (tmpFrame.size.height > self.frame.size.height)
        {
            tmpFrame = self.bounds;
        }
        else
        {
            tmpFrame.size = CGSizeMake(50, 50);
            tmpFrame.origin.x = self.bounds.size.width/2 - tmpFrame.size.width/2;
            tmpFrame.origin.y = self.bounds.size.height/2 - tmpFrame.size.height/2;
        }
        _imgViewSpinner.frame = tmpFrame;
    }
    return _imgViewSpinner;
}

-(void)startAnimation
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(M_2_PI, 0.0f, 0.0f, 1.0);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    rotationAnimation.duration = 1/self.framesPerSecond;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    rotationAnimation.removedOnCompletion = NO;
    
    [self.imgViewSpinner.layer addAnimation:rotationAnimation forKey:@"transform"];
}

-(void)stopAnimation
{
    [self.imgViewSpinner.layer removeAllAnimations];
}

+(SpinnerView *)spinnerView
{
    return [self spinerViewWithFrame:[UIScreen mainScreen].bounds];
}

+ (SpinnerView *)spinerViewWithFrame:(CGRect)frame
{
    SpinnerView* tmpProgress = [[SpinnerView alloc] initWithFrame:frame];
    tmpProgress.backgroundColor = [UIColor clearColor];
    tmpProgress.tag = kSpinnerViewTag;
    return tmpProgress;
}

- (void)dealloc
{
    [self stopAnimation];
}

@end
