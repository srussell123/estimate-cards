//
//  ECMenuViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/24/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECMenuViewController.h"
#import "ECDeckController.h"
#import "ECSlidingViewController.h"
#import "ECDeckViewController.h"

NSString *const ECDeckSelectorCellReuseId = @"DeckSelectorReuseId";

@interface ECMenuViewController ()

@property (nonatomic, strong) ECDeckController *deckController;
@property (nonatomic, strong) NSArray *deckNames;

@end

@implementation ECMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deckController = [[ECDeckController alloc] init];
    self.deckNames = [self.deckController availableDecks];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ECDeckSelectorCellReuseId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)deckForIndexPath:(NSIndexPath*)indexPath {
    
    NSString *name = self.deckNames[indexPath.section];
    NSDictionary *deck = [self.deckController deckNamed:name];
    
    return deck;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.deckNames.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *deck = [self deckForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    return [deck[@"values"] count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ECDeckSelectorCellReuseId forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.frame];
    NSDictionary *deck = [self deckForIndexPath:indexPath];
    label.text = [deck[@"values"] objectAtIndex:indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = self.deckNames[indexPath.section];
    NSLog(@"User tapped deck %@", name);
    
    //TODO: figure out a better way to do this, maybe?
    ECSlidingViewController *parent = (ECSlidingViewController*)self.parentViewController;
    ECDeckViewController *deckVC = (ECDeckViewController*)parent.topViewController;
    deckVC.selectedDeck = name;
}

@end
