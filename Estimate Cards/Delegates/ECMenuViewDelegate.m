//
//  ECMenuViewDelegate.m
//  Estimate Cards
//
//  Created by Christopher Martin on 5/4/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECMenuViewDelegate.h"

@implementation ECMenuViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(20, 20);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
}
@end
