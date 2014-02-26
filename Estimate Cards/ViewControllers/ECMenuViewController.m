//
//  ECMenuViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/24/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECMenuViewController.h"

NSString *const kECDeckSelectorCellReuseId = @"DeckSelectorReuseId";

@interface ECMenuViewController ()

@property (nonatomic, strong) NSDictionary *decks;

@end

@implementation ECMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.decks = @{
                   @"Squared": @[@"2", @"4", @"8", @"16"],
                   @"Squared Question Mark": @[@"2", @"4", @"8", @"??"],
                   @"Fiboniacci": @[@"1", @"2", @"3", @"5"],
                   @"Shirt Size": @[@"S", @"M", @"L", @"XL"]
                   };
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kECDeckSelectorCellReuseId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)deckValueForIndexPath:(NSIndexPath*)indexPath{
    NSString *key = [self.decks allKeys][indexPath.section];
    NSString *value = self.decks[key][indexPath.item];
    
    return value;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.decks allKeys].count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *key = [self.decks allKeys][section];
    NSArray *cards = self.decks[key];
    
    return cards.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kECDeckSelectorCellReuseId forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.frame];
    label.text = [self deckValueForIndexPath:indexPath];
    label.textAlignment = NSTextAlignmentCenter;
    
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *deck = [self.decks allKeys][indexPath.section];
    NSLog(@"User tapped deck %@", deck);
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(20, 20);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
}

@end
