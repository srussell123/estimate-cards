//
//  ECZoomInTransition.h
//  Estimate Cards
//
//  Created by Christopher Martin on 2/18/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ECZoomMode) {
    ECZoomModeIn = 0,
    ECZoomModeOut = 1
};

@interface ECZoomTransition : NSObject <UIViewControllerAnimatedTransitioning>

-(instancetype)initWithZoomMode:(ECZoomMode)zoomMode startRect:(CGRect)startRect;

@end
