//
//  ECDeckViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

//Cells and Xibs
#import "ECCardCell.h"

//View Controllers
#import "ECDeckViewController.h"

//Layouts
#import "ECDeckLayout.h"
#import "ECBigCardLayout.h"

//Menu and Transitions
#import "UIViewController+ECSlidingViewController.h"
#import "ECDynamicTransition.h"

//Data Controllers
#import "ECDeckController.h"

@interface ECDeckViewController ()

@property (nonatomic, strong) ECDynamicTransition *transition;
@property (nonatomic, strong) ECDeckController *deckController;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@property (nonatomic, strong) NSDictionary *deckInfo;
@end

@implementation ECDeckViewController

- (void)configureTransition {
    self.transition = [[ECDynamicTransition alloc] init];
    self.transition.slidingViewController = self.slidingViewController;
    self.slidingViewController.delegate = self.transition;
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
    self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
    [self.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    
}

- (void)configureTableView {
    UINib *nib = [UINib nibWithNibName:@"ECCardCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[ECCardCell cellReuseId]];   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTransition];
    [self configureTableView];
    
    self.deckController = [[ECDeckController alloc] init];
    //TODO: make this not hard coded
    self.selectedDeck = @"Fibonacci";
    self.deckInfo = [self.deckController deckNamed:self.selectedDeck];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showBigCardViewForItemAtIndexPath:(NSIndexPath*)indexPath {
    
    //TODO: maybe use startInteractiveTransitionToCollectionViewLayout:completion?
    __weak typeof(self)weakSelf = self;
    [self.collectionView setCollectionViewLayout:[[ECBigCardLayout alloc] init] animated:YES completion:^(BOOL finished) {
        NSLog(@"DECK VIEW CONTROLLER>>INFO>>Finished animating to Big Card view");
        [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }];
    
}

- (void)setSelectedDeck:(NSString *)selectedDeck {
    _selectedDeck = selectedDeck;
    self.deckInfo = [self.deckController deckNamed:self.selectedDeck];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.deckInfo[@"values"] count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ECCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ECCardCell cellReuseId] forIndexPath:indexPath];
    
    NSString *displayValue = self.deckInfo[@"values"][indexPath.item];
    [cell setDisplayValue:displayValue];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showBigCardViewForItemAtIndexPath:indexPath];
}

#pragma mark - Motion Detection
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSUInteger randomIndex = arc4random_uniform([self.deckInfo[@"values"] count]);
        NSIndexPath *path = [NSIndexPath indexPathForItem:randomIndex inSection:0];
        
        [self showBigCardViewForItemAtIndexPath:path];
    }
}

#pragma mark - Tranistion Stuff
- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
}
@end
