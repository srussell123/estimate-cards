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

@interface ECDeckViewController ()

@property (nonatomic, strong) ECDynamicTransition *transition;
@property (nonatomic, strong) NSArray *cards;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UICollectionViewTransitionLayout *transitionLayout;
@end

@implementation ECDeckViewController

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
    
    //configure the transition for swipe menu
    self.transition = [[ECDynamicTransition alloc] init];
    self.transition.slidingViewController = self.slidingViewController;
    self.slidingViewController.delegate = self.transition;
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
    self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
    [self.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    
    UINib *nib = [UINib nibWithNibName:@"ECCardCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[ECCardCell cellReuseId]];
    
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    
    self.cards = @[@"2", @"4", @"8", @"??"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showBigCardViewForItemAtIndexPath:(NSIndexPath*)indexPath {
    
    //TODO: maybe use startInteractiveTransitionToCollectionViewLayout:completion?
    __weak typeof(self)weakSelf = self;
    [self.collectionView setCollectionViewLayout:[[ECBigCardLayout alloc] init] animated:YES completion:^(BOOL finished) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"Finished animating to big card view");
        [strongSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [strongSelf.view addGestureRecognizer:strongSelf.pinchGesture];
    }];
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

#pragma mark - Gesture Handling
- (void)handlePinchGesture:(UIPinchGestureRecognizer*)recognizer {
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.transitionLayout = [self.collectionView startInteractiveTransitionToCollectionViewLayout:[[ECDeckLayout alloc] init] completion:^(BOOL completed, BOOL finish) {
                NSLog(@"Completed transition animation");
            }];
            break;
            
        case UIGestureRecognizerStateCancelled:
            [self.collectionView cancelInteractiveTransition];
            break;
            
        case UIGestureRecognizerStateChanged:
            self.transitionLayout.transitionProgress = 100.0 - recognizer.scale;
            
        default:
            NSLog(@"Unknown recognizer state");
            break;
    }
    if (recognizer.state == UIGestureRecognizerStateBegan) {

    } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
        [self.collectionView cancelInteractiveTransition];
    }
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"User tapped card %@", self.cards[indexPath.item]);
    
    [self showBigCardViewForItemAtIndexPath:indexPath];
}

#pragma mark - Motion Detection
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSUInteger randomIndex = arc4random_uniform(self.cards.count);
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
