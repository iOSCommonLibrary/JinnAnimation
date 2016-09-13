/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UICollisionBehaviorViewController.m
 **  Description: UICollisionBehavior 碰撞行为
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UICollisionBehaviorViewController.h"

@interface UICollisionBehaviorViewController ()

@property (nonatomic, strong) UIImageView            *imageView1;
@property (nonatomic, strong) UIImageView            *imageView2;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIDynamicAnimator      *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior      *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior    *collisionBehavior;

@end

@implementation UICollisionBehaviorViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.imageView2];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [self addBehaviors];
}

#pragma mark - Behavior

- (void)addBehaviors
{
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
}

#pragma mark - GestureRecognizer

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer
{
    self.imageView1.transform = CGAffineTransformMakeRotation(M_PI / 5);
    self.imageView1.center = [gestureRecognizer locationInView:self.view];
    
    [self.dynamicAnimator removeAllBehaviors];
    [self addBehaviors];
}

#pragma mark - Getter / Setter

- (UIImageView *)imageView1
{
    if (_imageView1 == nil)
    {
        _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"webchat"]];
        _imageView1.backgroundColor = [UIColor yellowColor];
        _imageView1.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 70, 0, 140, 140);
        _imageView1.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView1.layer.borderWidth = 1;
        _imageView1.contentMode = UIViewContentModeCenter;
    }
    
    return _imageView1;
}

- (UIImageView *)imageView2
{
    if (_imageView2 == nil)
    {
        _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq"]];
        _imageView2.backgroundColor = [UIColor yellowColor];
        _imageView2.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2, 200, 140, 140);
        _imageView2.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView2.layer.borderWidth = 1;
        _imageView2.contentMode = UIViewContentModeCenter;
    }
    
    return _imageView2;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_tapGestureRecognizer == nil)
    {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    
    return _tapGestureRecognizer;
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
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView1, self.imageView2]];
    }
    
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior
{
    if (_collisionBehavior == nil)
    {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView1, self.imageView2]];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    
    return _collisionBehavior;
}

@end