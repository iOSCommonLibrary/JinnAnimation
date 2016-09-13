/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UIGravityBehaviorViewController.m
 **  Description: UIGravityBehavior 重力行为
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UIGravityBehaviorViewController.h"

@interface UIGravityBehaviorViewController ()

@property (nonatomic, strong) UIImageView            *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIDynamicAnimator      *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior      *gravityBehavior;

@end

@implementation UIGravityBehaviorViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
}

#pragma mark - GestureRecognizer

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.dynamicAnimator removeBehavior:self.gravityBehavior];
    [self.imageView setCenter:[gestureRecognizer locationInView:self.view]];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
}

#pragma mark - Getter / Setter

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
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
    }
    
    return _gravityBehavior;
}

@end