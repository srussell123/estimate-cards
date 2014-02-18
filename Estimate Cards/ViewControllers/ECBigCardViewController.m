//
//  ECBigCardViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECBigCardViewController.h"
#import "ECCardCell.h"

@interface ECBigCardViewController ()

@property (nonatomic, strong) UISwipeGestureRecognizer *gestureRecognizer;

@end

@implementation ECBigCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ECCardCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[ECCardCell cellReuseId]];
    
    self.gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    [self.collectionView addGestureRecognizer:self.gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:self.pathToView atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

#pragma mark - Gesture Handler
-(void)handleGesture:(UISwipeGestureRecognizer*)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded && recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cards.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ECCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ECCardCell cellReuseId] forIndexPath:indexPath];
    
    [cell setDisplayValue:self.cards[indexPath.item]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    size.height -= 5.0;
    size.width -= 10.0;
    
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0, 5.0, 1.0, 5.0);
}
@end
