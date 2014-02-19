//
//  ECZoomTransition.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/18/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECZoomTransition.h"

const CGFloat kECZoomTransitionDuration = 1.5;

@implementation ECZoomTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return kECZoomTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect sourceRect = [transitionContext initialFrameForViewController:from];
    CGRect initialTarget = [transitionContext initialFrameForViewController:to];
    
    CGAffineTransform rotation = CGAffineTransformMakeRotation(- M_PI / 2);
    to.view.layer.anchorPoint = CGPointZero;
    to.view.frame = sourceRect;
    to.view.transform = rotation;
    
    UIView *container = [transitionContext containerView];
    [container addSubview:to.view];
    
    [UIView animateWithDuration:kECZoomTransitionDuration delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        to.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)animationEnded:(BOOL)transitionCompleted{
    NSLog(@"Finished Animation: %@", transitionCompleted ? @"YES" : @"NO");
}

@end
