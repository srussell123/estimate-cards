//
//  ECBigCardLayout.m
//  Estimate Cards
//
//  Created by Christopher Martin on 5/4/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECBigCardLayout.h"

@implementation ECBigCardLayout

- (CGSize)itemSize {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    size.height -= 5.0;
    size.width -= 10.0;
    
    return size;
}

- (UIEdgeInsets)sectionInset {
    return UIEdgeInsetsMake(5.0, 5.0, 1.0, 5.0);
}


@end
