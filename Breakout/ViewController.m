//
//  ViewController.m
//  Breakout
//
//  Created by Manas Pradhan on 3/20/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "PelletView.h"
#import "BlockView.h"

@interface ViewController () <UICollisionBehaviorDelegate>
{
    IBOutlet PaddleView   *paddleView;
    IBOutlet PelletView   *pelletView;
    IBOutlet BlockView    *blockView;
    
    UIDynamicAnimator     *dynamicAnimator;
    UIPushBehavior        *pushBehavior;
    UICollisionBehavior   *collisionBehavior;
    UIDynamicItemBehavior *paddleDynamicItemBehavior;
    UIDynamicItemBehavior *pelletDynamicItemBehavior;
    UIDynamicItemBehavior *blockDynamicBehavior;
    
    NSMutableArray        *blocks;
    
    CGFloat               rectX;
    CGFloat               rectY;
}
@property BlockView *tempBlock;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < 25; i++)
    {
        rectX = arc4random() % 280;
        rectY = arc4random() % 200;

        self.tempBlock = [[BlockView alloc] initWithFrame:CGRectMake(rectX, rectY, 40, 40)];
        self.tempBlock.backgroundColor = [UIColor greenColor];
        
        [self.view addSubview:self.tempBlock];
        if (i == 0)
        {
            blocks = [[NSMutableArray alloc]initWithObjects:self.tempBlock, nil];
        }
        else
        {
            [blocks addObject:self.tempBlock];
        }
    }
    
    dynamicAnimator           = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior              = [[UIPushBehavior alloc] initWithItems:@[pelletView] mode:UIPushBehaviorModeInstantaneous];
    collisionBehavior         = [[UICollisionBehavior alloc] initWithItems:@[pelletView, paddleView, blockView]];
    pelletDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[pelletView]];
    paddleDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    blockDynamicBehavior      = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
    
    paddleDynamicItemBehavior.allowsRotation = NO;
    paddleDynamicItemBehavior.density        = 10000000;
    
    pelletDynamicItemBehavior.allowsRotation = NO;
    pelletDynamicItemBehavior.elasticity     = 1.0;
    pelletDynamicItemBehavior.friction       = 0.0;
    pelletDynamicItemBehavior.resistance     = 0.0;
    
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate                     = self;
    
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active        = YES;
    pushBehavior.magnitude     = 0.1;
    
    blockDynamicBehavior.allowsRotation = NO;
    blockDynamicBehavior.density        = 10000000;

    [dynamicAnimator addBehavior:paddleDynamicItemBehavior];
    [dynamicAnimator addBehavior:pelletDynamicItemBehavior];
    [dynamicAnimator addBehavior:collisionBehavior];
    [dynamicAnimator addBehavior:pushBehavior];
    [dynamicAnimator addBehavior:blockDynamicBehavior];
    
//    for (int i = 0; i < 10; i++)
//    {
//        rectX = arc4random() % 280;
//        rectY = arc4random() % 200;
//        
//        self.tempBlock = [[BlockView alloc] initWithFrame:CGRectMake(rectX, rectY, 40, 40)];
//        self.tempBlock.backgroundColor = [UIColor greenColor];
//        
//        //[self.view addSubview:self.tempBlock];
//        
//        if (i == 0)
//        {
//            blocks = [[NSMutableArray alloc]initWithObjects:self.tempBlock, nil];
//        }
//        else
//        {
//            [blocks addObject:self.tempBlock];
//        }
//        [self.view addSubview:self.tempBlock];
//    }
}

- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if (pelletView.frame.origin.y >= (self.view.frame.size.height-(pelletView.frame.size.height*2)))
    {
        pelletView.center = self.view.center;
        [dynamicAnimator updateItemUsingCurrentState:pelletView];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    if ([item2 isEqual:blockView] || [item1 isEqual:blockView]) {
        [collisionBehavior removeItem:blockView];
        [blockView removeFromSuperview];
    }
    
//    if ([item2 isMemberOfClass:[BlockView class]])
//    {
//        [collisionBehavior removeItem:item2];
//        [blocks removeObject:item2];
//        //you can only remove a view from itʻs Superview
//        [(BlockView*)item2 removeFromSuperview];
//        [dynamicAnimator updateItemUsingCurrentState:item2];
//    }
    
//    if ([item1 isMemberOfClass:[BlockView class]])
//    {
//        [collisionBehavior removeItem:item1];
//        [blocks removeObject:item1];
//        //you can only remove a view from itʻs Superview
//        [(BlockView*)item2 removeFromSuperview];
//        [dynamicAnimator updateItemUsingCurrentState:item1];
//    }
}


@end
