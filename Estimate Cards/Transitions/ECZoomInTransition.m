//
//  ECZoomInTransition.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/18/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECZoomInTransition.h"

const CGFloat kECZoomTransitionDuration = .75;

@implementation ECZoomInTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return kECZoomTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    to.view.transform = CGAffineTransformMakeScale(0, 0);
    [container addSubview:to.view];
    
    [UIView animateWithDuration:kECZoomTransitionDuration animations:^{
        to.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)animationEnded:(BOOL)transitionCompleted{
    NSLog(@"Finished Animation: %@", transitionCompleted ? @"YES" : @"NO");
}

@end
