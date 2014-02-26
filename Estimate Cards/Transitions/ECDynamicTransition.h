//
//  ECDynamicTransition.h
//  Estimate Cards
//
//  Created by Christopher Martin on 2/25/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"
#import "ECPercentDrivenInteractiveTransition.h"

@interface ECDynamicTransition : NSObject <UIViewControllerInteractiveTransitioning,
                                            UIDynamicAnimatorDelegate,
                                            ECSlidingViewControllerDelegate>

@property (nonatomic, assign) ECSlidingViewController *slidingViewController;

-(void)handlePanGesture:(UIPanGestureRecognizer*)recognizer;

@end
