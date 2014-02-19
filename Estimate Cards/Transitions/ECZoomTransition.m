//
//  ECZoomInTransition.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/18/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECZoomTransition.h"

const CGFloat kECZoomTransitionDuration = .75;

@interface ECZoomTransition ()

@property (nonatomic, assign) ECZoomMode zoomMode;

@end

@implementation ECZoomTransition

-(instancetype)initWithZoomMode:(ECZoomMode)zoomMode{
    self = [super init];
    
    if (self) {
        self.zoomMode = zoomMode;
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return kECZoomTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.zoomMode == ECZoomModeOut) {
        [container insertSubview:to.view aboveSubview:from.view];
        [container addSubview:to.view];
    } else {
        to.view.transform = CGAffineTransformMakeScale(0, 0);
        [container addSubview:to.view];
    }
    
    
    [UIView animateWithDuration:kECZoomTransitionDuration animations:^{
        if (self.zoomMode == ECZoomModeOut) {
            from.view.transform = CGAffineTransformMakeScale(0, 0);
        } else {
            to.view.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)animationEnded:(BOOL)transitionCompleted{
    NSLog(@"Finished Animation: %@", transitionCompleted ? @"YES" : @"NO");
}

@end
