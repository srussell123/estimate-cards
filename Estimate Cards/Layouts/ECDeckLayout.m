//
//  ECDeckLayout.m
//  Estimate Cards
//
//  Created by Christopher Martin on 5/4/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECDeckLayout.h"

@implementation ECDeckLayout

- (CGSize)itemSize {
    return CGSizeMake(150, 266.5);
}

- (UIEdgeInsets)sectionInset {
    return UIEdgeInsetsMake(5.0, 5.0, 1.0, 5.0);
}

@end
