//
//  ECDeckViewDelegate.m
//  Estimate Cards
//
//  Created by Christopher Martin on 5/4/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECDeckViewDelegate.h"

@implementation ECDeckViewDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 266.5);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0, 5.0, 1.0, 5.0);
}

@end
