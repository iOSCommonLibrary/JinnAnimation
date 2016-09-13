/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UIPushBehaviorViewController.m
 **  Description: UIPushBehavior 推动行为
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UIPushBehaviorViewController.h"

@interface UIPushBehaviorViewController ()

@property (nonatomic, strong) UIView                 *nailView;
@property (nonatomic, strong) UIImageView            *imageView;
@property (nonatomic, strong) CAShapeLayer           *shapeLayer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIDynamicAnimator      *dynamicAnimator;
@property (nonatomic, strong) UIPushBehavior         *pushBehavior;

@end

@implementation UIPushBehaviorViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.nailView];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.nailView setCenter:self.view.center];
}

#pragma mark - Private

- (void)updateLine
{
    if (self.shapeLayer == nil)
    {
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineWidth = 1;
        self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        self.shapeLayer.strokeEnd = 1;
        [self.view.layer addSublayer:self.shapeLayer];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.nailView.center];
    [path addLineToPoint:self.imageView.center];
    self.shapeLayer.path = path.CGPath;
}

- (void)clearLine
{
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
}

- (void)shoot:(CGPoint)shootPoint
{
    CGPoint nailPoint = self.view.center;
    CGFloat distance = MAX(sqrt(pow(nailPoint.x - shootPoint.x, 2) + pow(nailPoint.y - shootPoint.y, 2)), 10);
    CGFloat angle = atan2(nailPoint.y - shootPoint.y, nailPoint.x - shootPoint.x);
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.imageView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.magnitude = distance / 5.f;
    self.pushBehavior.angle = angle;
    self.pushBehavior.active = YES;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.imageView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.imageView]];
    
    [self.dynamicAnimator addBehavior:self.pushBehavior];
    [self.dynamicAnimator addBehavior:collisionBehavior];
    [self.dynamicAnimator addBehavior:gravityBehavior];
}

#pragma mark - GestureRecognizer

- (void)panAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||
        gestureRecognizer.state == UIGestureRecognizerStateCancelled ||
        gestureRecognizer.state == UIGestureRecognizerStateFailed)
    {
        [self clearLine];
        [self.dynamicAnimator removeAllBehaviors];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        [self.imageView setCenter:point];
        [self updateLine];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [self clearLine];
        [self shoot:point];
    }
}

#pragma mark - Getter / Setter

- (UIView *)nailView
{
    if (_nailView == nil)
    {
        _nailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _nailView.backgroundColor = [UIColor blackColor];
        _nailView.layer.cornerRadius = 10.f;
    }
    
    return _nailView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"webchat"]];
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.frame = CGRectMake(0, 0, 140, 140);
        _imageView.center = self.view.center;
        _imageView.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView.layer.borderWidth = 1;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    
    return _imageView;
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (_panGestureRecognizer == nil)
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    }
    
    return _panGestureRecognizer;
}

- (UIDynamicAnimator *)dynamicAnimator
{
    if (_dynamicAnimator == nil)
    {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    
    return _dynamicAnimator;
}

@end