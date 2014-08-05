//
//  ECDeckViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

//Data
#import "ECDeckController.h"

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

@interface ECDeckViewController ()

@property (nonatomic, strong) ECDynamicTransition *transition;
@property (nonatomic, strong) ECDeckController *deckController;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@property (nonatomic, strong) NSString *currentDeckName;
@end

@implementation ECDeckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSwipeMenu];
    
    self.deckController = [[ECDeckController alloc] init];
     //TODO: save the last displayed deck in user defaults
    NSString *deck = [[self.deckController availableDecks] firstObject];
    self.currentDeckName = deck;
    
    UINib *nib = [UINib nibWithNibName:@"ECCardCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[ECCardCell cellReuseId]];
}

- (void)configureSwipeMenu {
    self.transition = [[ECDynamicTransition alloc] init];
    self.transition.slidingViewController = self.slidingViewController;
    self.slidingViewController.delegate = self.transition;
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
    self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
    [self.view addGestureRecognizer:self.dynamicTransitionPanGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showBigCardViewForItemAtIndexPath:(NSIndexPath*)indexPath {
    
    //TODO: maybe use startInteractiveTransitionToCollectionViewLayout:completion?
    __weak typeof(self)weakSelf = self;
    [self.collectionView setCollectionViewLayout:[[ECBigCardLayout alloc] init] animated:YES completion:^(BOOL finished) {
        NSLog(@"Finished animating to big card view");
        [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *deck = [self.deckController deckNamed:self.currentDeckName];
    return [deck[@"values"] count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ECCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ECCardCell cellReuseId] forIndexPath:indexPath];
    
    [cell setDisplayValue:[self.deckController deckNamed:self.currentDeckName][@"values"][indexPath.item]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"User tapped card %@", [self.deckController deckNamed:self.currentDeckName][@"values"][indexPath.item]);
    
    [self showBigCardViewForItemAtIndexPath:indexPath];
}

#pragma mark - Motion Detection
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSUInteger randomIndex = arc4random_uniform([self.deckController deckNamed:self.currentDeckName].count);
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

#pragma mark - Public Methods
- (void)displayDeckNamed:(NSString *)deckName {
    self.currentDeckName = deckName;
    
    [self.collectionView reloadData];
}
@end
