//
//  ECMenuViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/24/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECMenuViewController.h"
#import "ECDeckController.h"
#import "ECMenuCell.h"

NSString *const ECMenuViewControllerStoryboardId = @"MenuViewController";
NSString *const ECDeckSelectorCellReuseId = @"DeckSelectorReuseId";

@interface ECMenuViewController ()

@property (nonatomic, strong) ECDeckController *deckController;

@end

@implementation ECMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deckController = [[ECDeckController alloc] init];
    
    [self.tableView registerClass:[ECMenuCell class] forCellReuseIdentifier:ECDeckSelectorCellReuseId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)deckForIndexPath:(NSIndexPath*)indexPath {
    
    NSString *name = [self.deckController availableDecks][indexPath.row];
    NSDictionary *deck = [self.deckController deckNamed:name];
    
    return deck;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.deckController availableDecks].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ECDeckSelectorCellReuseId forIndexPath:indexPath];
    NSDictionary *deck = [self deckForIndexPath:indexPath];
    
    cell.textLabel.text = deck[@"name"];
    
    __block NSMutableString *values = [NSMutableString stringWithString:@""];
    [deck[@"values"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [values appendFormat:@"%@ ", obj];
    }];
    
    cell.detailTextLabel.text = values;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = [self.deckController availableDecks][indexPath.row];
    NSLog(@"Picked %@", name);
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
@end
