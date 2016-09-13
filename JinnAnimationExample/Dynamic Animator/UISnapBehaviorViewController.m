/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UISnapBehaviorViewController.m
 **  Description: UISnapBehavior 吸附行为
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UISnapBehaviorViewController.h"

@interface UISnapBehaviorViewController ()

@property (nonatomic, strong) UIImageView            *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIDynamicAnimator      *dynamicAnimator;
@property (nonatomic, strong) UISnapBehavior         *snapBehavior;

@end

@implementation UISnapBehaviorViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

#pragma mark - GestureRecognizer

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.dynamicAnimator removeBehavior:self.snapBehavior];
    CGPoint snapPoint = [gestureRecognizer locationInView:self.view];
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:snapPoint];
    [self.dynamicAnimator addBehavior:self.snapBehavior];
}

#pragma mark - Getter / Setter

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

@end