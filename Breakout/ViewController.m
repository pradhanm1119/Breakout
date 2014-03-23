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
    
    UIColor               *customColor1;
    UIColor               *customColor2;
    UIColor               *customColor3;
    UIColor               *customColor4;
    UIColor               *customColor5;
    UIColor               *customColor6;
    
    BOOL                  startAgain;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self initialize];
    //[self generateBlocks];
    //[self playGame];
    customColor1 = [UIColor colorWithRed:214/255.0f green:105/255.0f blue:209/255.0f alpha:1.0f];
    customColor2 = [UIColor colorWithRed:5/255.0f green:189/255.0f blue:168/255.0f alpha:1.0f];
    customColor3 = [UIColor colorWithRed:221/255.0f green:107/255.0f blue:6/255.0f alpha:1.0f];
    customColor4 = [UIColor colorWithRed:65/255.0f green:26/255.0f blue:240/255.0f alpha:1.0f];
    customColor5 = [UIColor colorWithRed:235/255.0f green:205/255.0f blue:242/255.0f alpha:1.0f];
    customColor6 = [UIColor colorWithRed:130/255.0f green:90/255.0f blue:25/255.0f alpha:1.0f];
    
    dynamicAnimator           = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior              = [[UIPushBehavior alloc] initWithItems:@[pelletView] mode:UIPushBehaviorModeInstantaneous];
    collisionBehavior         = [[UICollisionBehavior alloc] initWithItems:@[pelletView, paddleView, blockView]];
    pelletDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[pelletView]];
    paddleDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    
    paddleDynamicItemBehavior.allowsRotation = NO;
    paddleDynamicItemBehavior.density        = 10000000;
    
    pelletDynamicItemBehavior.allowsRotation = NO;
    pelletDynamicItemBehavior.elasticity     = 1.0;
    pelletDynamicItemBehavior.friction       = 0.0;
    pelletDynamicItemBehavior.resistance     = 0.0;
    
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate                     = self;
    
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active        = YES;
    pushBehavior.magnitude     = 0.3;
    
    for (int i = 0; i < 10; i++)
    {
        rectX = arc4random() % 280;
        rectY = arc4random() % 200;
    
        blockView = [[BlockView alloc] initWithFrame:CGRectMake(rectX, rectY, 40, 20)];
        blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
    
        if ((rectX >= 0) && (rectX < 90))
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor1;
            }
            else
            {

            blockView.backgroundColor = customColor2;            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
        else if ((rectX >= 90) && (rectX < 180))
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor3;
            }
            else
            {
                blockView.backgroundColor = customColor4;
            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
        else
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor5;
            }
            else
            {
                blockView.backgroundColor = customColor6;
            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
    
        if (i == 0)
        {
            blocks = [[NSMutableArray alloc]initWithObjects:blockView, nil];
            blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
        }
        else
        {
            [blocks addObject:blockView];
            [blockDynamicBehavior addItem:blockView];
        }
        [self.view addSubview:blockView];
    }
    
    [dynamicAnimator addBehavior:paddleDynamicItemBehavior];
    [dynamicAnimator addBehavior:pelletDynamicItemBehavior];
    [dynamicAnimator addBehavior:collisionBehavior];
    [dynamicAnimator addBehavior:pushBehavior];
    [dynamicAnimator addBehavior:blockDynamicBehavior];
}

- (void)initialize
{
    customColor1 = [UIColor colorWithRed:214/255.0f green:105/255.0f blue:209/255.0f alpha:1.0f];
    customColor2 = [UIColor colorWithRed:5/255.0f green:189/255.0f blue:168/255.0f alpha:1.0f];
    customColor3 = [UIColor colorWithRed:221/255.0f green:107/255.0f blue:6/255.0f alpha:1.0f];
    customColor4 = [UIColor colorWithRed:65/255.0f green:26/255.0f blue:240/255.0f alpha:1.0f];
    customColor5 = [UIColor colorWithRed:235/255.0f green:205/255.0f blue:242/255.0f alpha:1.0f];
    customColor6 = [UIColor colorWithRed:130/255.0f green:90/255.0f blue:25/255.0f alpha:1.0f];
    
    dynamicAnimator           = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior              = [[UIPushBehavior alloc] initWithItems:@[pelletView] mode:UIPushBehaviorModeInstantaneous];
    collisionBehavior         = [[UICollisionBehavior alloc] initWithItems:@[pelletView, paddleView, blockView]];
    pelletDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[pelletView]];
    paddleDynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    
    [self initializeBlocks];
    
    paddleDynamicItemBehavior.allowsRotation = NO;
    paddleDynamicItemBehavior.density        = 10000000;
    
    pelletDynamicItemBehavior.allowsRotation = NO;
    pelletDynamicItemBehavior.elasticity     = 1.0;
    pelletDynamicItemBehavior.friction       = 0.0;
    pelletDynamicItemBehavior.resistance     = 0.0;
    
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate                     = self;
    
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active        = YES;
    pushBehavior.magnitude     = 0.3;
    
    [dynamicAnimator addBehavior:paddleDynamicItemBehavior];
    [dynamicAnimator addBehavior:pelletDynamicItemBehavior];
    [dynamicAnimator addBehavior:collisionBehavior];
    [dynamicAnimator addBehavior:pushBehavior];
    [dynamicAnimator addBehavior:blockDynamicBehavior];
}

- (void)generateBlocks
{
    for (int i = 0; i < 10; i++)
    {
        rectX = arc4random() % 280;
        rectY = arc4random() % 200;
        
//        blockView = [[BlockView alloc] initWithFrame:CGRectMake(rectX, rectY, 40, 20)];
//        blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
//        [self initializeBlocks];
        
        if ((rectX >= 0) && (rectX < 90))
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor1;
            }
            else
            {
                blockView.backgroundColor = customColor2;
            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
        else if ((rectX >= 90) && (rectX < 180))
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor3;
            }
            else
            {
                blockView.backgroundColor = customColor4;
            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
        else
        {
            if ((int)rectX % 2 == 0)
            {
                blockView.backgroundColor = customColor5;
            }
            else
            {
                blockView.backgroundColor = customColor6;
            }
            blockDynamicBehavior.allowsRotation = NO;
            blockDynamicBehavior.density        = 1;
            blockDynamicBehavior.elasticity     = 1;
            blockDynamicBehavior.resistance     = 0;
            [collisionBehavior addItem:blockView];
        }
        
        if (i == 0)
        {
            blocks = [[NSMutableArray alloc]initWithObjects:blockView, nil];
            blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
        }
        else
        {
            [blocks addObject:blockView];
            [blockDynamicBehavior addItem:blockView];
        }
        [self.view addSubview:blockView];
    }
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
    if ([item2 isKindOfClass:[BlockView class]])
    {
        [collisionBehavior removeItem:item2];
        [blocks removeObject:item2];
        //NSLog(@("The block count is %d"), [blocks count]);
        
        //you can only remove a view from itʻs Superview
        [(BlockView*)item2 removeFromSuperview];
        [dynamicAnimator updateItemUsingCurrentState:item2];
    }
    
    if ([self shouldStartAgain])
    {
//        [self resetGame];
//        [self initializeBlocks];
        UIAlertView *alertViewMessage = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"wow just wow pat yourself on the back" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertViewMessage show];
        
        pelletView.center = self.view.center;
        [dynamicAnimator updateItemUsingCurrentState:pelletView];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        //[self viewDidLoad];
        [self initialize];
        [self generateBlocks];
    }
    else
    {
        //[self viewDidLoad];
        [self initialize];
        [self generateBlocks];
    }
}

- (void)initializeBlocks
{
    blockView = [[BlockView alloc] initWithFrame:CGRectMake(rectX, rectY, 40, 20)];
    blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[blockView]];
}

- (BOOL)shouldStartAgain
{
    if ([blocks count] == 0)
        startAgain = YES;
    else
        startAgain = NO;
    
    return startAgain;
}

@end
