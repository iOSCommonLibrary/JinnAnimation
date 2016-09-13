/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UIAttachmentBehaviorViewController.m
 **  Description: UIAttachmentBehavior 连接行为
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UIAttachmentBehaviorViewController.h"

@interface UIAttachmentBehaviorViewController ()

@property (nonatomic, strong) UIView                 *nailView;
@property (nonatomic, strong) UIImageView            *imageView;
@property (nonatomic, strong) CAShapeLayer           *shapeLayer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIDynamicAnimator      *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior      *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior    *collisionBehavior;
@property (nonatomic, strong) UIAttachmentBehavior   *attachmentBehavior;

@end

@implementation UIAttachmentBehaviorViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.nailView];
    [self.view.layer addSublayer:self.shapeLayer];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
    [self.imageView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - Private

- (void)updateLine
{    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.nailView.center];
    [path addLineToPoint:self.imageView.center];
    self.shapeLayer.path = path.CGPath;
}

#pragma mark - GestureRecognizer

- (void)panAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    [self.nailView setCenter:[gestureRecognizer locationInView:self.view]];
    [self.attachmentBehavior setAnchorPoint:self.nailView.center];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    [self updateLine];
}

#pragma mark - Getter / Setter

- (UIView *)nailView
{
    if (_nailView == nil)
    {
        _nailView = [[UIView alloc] init];
        _nailView.backgroundColor = [UIColor blackColor];
        _nailView.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 10, 200, 20, 20);
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
        _imageView.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 70, 0, 140, 140);
        _imageView.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView.layer.borderWidth = 1;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    
    return _imageView;
}

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.lineWidth = 1;
        _shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        _shapeLayer.strokeEnd = 1;
    }
    
    return _shapeLayer;
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

- (UIGravityBehavior *)gravityBehavior
{
    if (_gravityBehavior == nil)
    {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
    }
    
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior
{
    if (_collisionBehavior == nil)
    {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView]];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    
    return _collisionBehavior;
}

- (UIAttachmentBehavior *)attachmentBehavior
{
    if (_attachmentBehavior == nil)
    {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.imageView
                                                        attachedToAnchor:self.nailView.center];
        _attachmentBehavior.length = 100;
        _attachmentBehavior.damping = 0.1;
        _attachmentBehavior.frequency = 0.6;
    }
    
    return _attachmentBehavior;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [self.imageView removeObserver:self forKeyPath:@"center"];
}

@end