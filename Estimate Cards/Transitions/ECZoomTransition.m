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
@property (nonatomic, assign) CGRect startRect;

@end

@implementation ECZoomTransition

-(instancetype)initWithZoomMode:(ECZoomMode)zoomMode startRect:(CGRect)startRect{
    self = [super init];
    
    if (self) {
        self.zoomMode = zoomMode;
        self.startRect = startRect;
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
    
    /*
    to.view.layer.borderWidth = 1.0;
    to.view.layer.borderColor = [[UIColor blueColor] CGColor];
    
    from.view.layer.borderWidth = 1.0;
    from.view.layer.borderColor = [[UIColor redColor] CGColor];
    */
    
    if (self.zoomMode == ECZoomModeOut) {
        [container insertSubview:to.view aboveSubview:from.view];
        [container addSubview:to.view];
    } else {
        //to.view.layer.anchorPoint = self.startRect.origin;
        //to.view.frame = self.startRect;
        to.view.transform = CGAffineTransformMakeScale(0, 0);
        [container addSubview:to.view];
    }
    
    [UIView animateWithDuration:kECZoomTransitionDuration animations:^{
        if (self.zoomMode == ECZoomModeOut) {
            from.view.transform = CGAffineTransformMakeScale(0, 0);
        } else {
            to.view.transform = CGAffineTransformIdentity;
            //to.view.center = CGPointMake(to.view.frame.size.width/2.0, to.view.frame.size.height/2.0);
        }
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)animationEnded:(BOOL)transitionCompleted{
    NSLog(@"Finished Animation: %@", transitionCompleted ? @"YES" : @"NO");
}

@end
