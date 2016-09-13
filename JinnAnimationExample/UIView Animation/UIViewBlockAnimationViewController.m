/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UIViewBlockAnimationViewController.m
 **  Description: UIViewBlockAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UIViewBlockAnimationViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface UIViewBlockAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation UIViewBlockAnimationViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.optionTableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.optionTableView.layer.borderWidth = 1;
    self.optionTableView.dataSource = self;
    self.optionTableView.delegate = self;
    
    self.imageView.image = self.images[0];
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    self.imageView.contentMode = UIViewContentModeCenter;
}

#pragma mark - Private

- (void)animationDidStart
{
    // 动画开始
    
    [self setAnimated:YES];
    [self.indicatorView startAnimating];
}

- (void)animationDidFinish
{
    // 动画结束
    
    [self setAnimated:NO];
    [self.indicatorView stopAnimating];
}

- (void)transitionDidFinish
{
    // 动画结束
    
    [self setAnimated:NO];
    [self.indicatorView stopAnimating];
    [self.images exchangeObjectAtIndex:0 withObjectAtIndex:1];
}

#pragma mark - Animation

- (void)translationAnimation
{
    [self.imageView setTransform:CGAffineTransformMakeTranslation(0, -100)];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [self.imageView setTransform:CGAffineTransformIdentity];
                     } completion:^(BOOL finished) {
                         [self animationDidFinish];
                     }];
}

- (void)scaleAnimation
{
    [self.imageView setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [self.imageView setTransform:CGAffineTransformIdentity];
                     } completion:^(BOOL finished) {
                         [self animationDidFinish];
                     }];
}

- (void)rotationAnimation
{
    [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [self.imageView setTransform:CGAffineTransformIdentity];
                     } completion:^(BOOL finished) {
                         [self animationDidFinish];
                     }];
}

- (void)alphaAnimation
{
    [self.imageView setAlpha:0];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         [self.imageView setAlpha:1];
                     } completion:^(BOOL finished) {
                         [self animationDidFinish];
                     }];
}

- (void)backgroundColorAnimation
{
    [self.imageView setBackgroundColor:[UIColor brownColor]];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         [self.imageView setBackgroundColor:[UIColor yellowColor]];
                     } completion:^(BOOL finished) {
                         [self animationDidFinish];
                     }];
}

- (void)keyframeAnimation
{
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView animateKeyframesWithDuration:6.f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
        }];
        [UIView addKeyframeWithRelativeStartTime:1/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setTransform:CGAffineTransformIdentity];
        }];
        [UIView addKeyframeWithRelativeStartTime:2/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
        }];
        [UIView addKeyframeWithRelativeStartTime:3/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setTransform:CGAffineTransformIdentity];
        }];
        [UIView addKeyframeWithRelativeStartTime:4/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setBackgroundColor:[UIColor brownColor]];
        }];
        [UIView addKeyframeWithRelativeStartTime:5/6.f relativeDuration:1/6.f animations:^{
            [self.imageView setBackgroundColor:[UIColor yellowColor]];
        }];
    } completion:^(BOOL finished) {
        [self animationDidFinish];
    }];
}

- (void)transitionWithView:(UIViewAnimationOptions)animationTransition
{
    [self.imageView setImage:self.images[0]];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView transitionWithView:self.imageView
                      duration:kAnimationDuration
                       options:animationTransition
                    animations:^{
                        [self.imageView setImage:self.images[1]];
                    } completion:^(BOOL finished) {
                        [self transitionDidFinish];
                    }];
}

- (void)transitionFromView:(UIViewAnimationOptions)animationTransition
{
    [self.imageView setImage:self.images[0]];
    [self animationDidStart];
    
    // 动画前后分割线
    
    [UIView transitionFromView:self.imageView
                        toView:self.imageView
                      duration:kAnimationDuration
                       options:(animationTransition | UIViewAnimationOptionShowHideTransitionViews)
                    completion:^(BOOL finished) {
                        [self transitionDidFinish];
                    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.optionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.optionTitles[section][1] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.optionTitles[section][0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifier = @"UIViewBlockAnimationTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    cell.textLabel.text = self.optionTitles[indexPath.section][1][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.animated)
    {
        return;
    }
    
    NSString *title = self.optionTitles[indexPath.section][1][indexPath.row];
    
    switch (indexPath.section)
    {
        case 0:
        {
            if ([title isEqualToString:@"translation"])
            {
                [self translationAnimation];
            }
            else if ([title isEqualToString:@"scale"])
            {
                [self scaleAnimation];
            }
            else if ([title isEqualToString:@"rotation"])
            {
                [self rotationAnimation];
            }
            else if ([title isEqualToString:@"alpha"])
            {
                [self alphaAnimation];
            }
            else if ([title isEqualToString:@"backgroundColor"])
            {
                [self backgroundColorAnimation];
            }
            else if ([title isEqualToString:@"keyframe"])
            {
                [self keyframeAnimation];
            }
        }
            break;
        case 1:
        {
            if ([title isEqualToString:@"none"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionNone];
            }
            else if ([title isEqualToString:@"flipFromLeft"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionFlipFromLeft];
            }
            else if ([title isEqualToString:@"flipFromRight"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionFlipFromRight];
            }
            else if ([title isEqualToString:@"curlUp"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionCurlUp];
            }
            else if ([title isEqualToString:@"curlDown"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionCurlDown];
            }
            else if ([title isEqualToString:@"crossDissolve"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionCrossDissolve];
            }
            else if ([title isEqualToString:@"flipFromTop"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionFlipFromTop];
            }
            else if ([title isEqualToString:@"flipFromBottom"])
            {
                [self transitionWithView:UIViewAnimationOptionTransitionFlipFromBottom];
            }
        }
            break;
        case 2:
        {
            if ([title isEqualToString:@"none"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionNone];
            }
            else if ([title isEqualToString:@"flipFromLeft"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionFlipFromLeft];
            }
            else if ([title isEqualToString:@"flipFromRight"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionFlipFromRight];
            }
            else if ([title isEqualToString:@"curlUp"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionCurlUp];
            }
            else if ([title isEqualToString:@"curlDown"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionCurlDown];
            }
            else if ([title isEqualToString:@"crossDissolve"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionCrossDissolve];
            }
            else if ([title isEqualToString:@"flipFromTop"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionFlipFromTop];
            }
            else if ([title isEqualToString:@"flipFromBottom"])
            {
                [self transitionFromView:UIViewAnimationOptionTransitionFlipFromBottom];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getter / Setter

- (NSArray *)optionTitles
{
    if (_optionTitles == nil)
    {
        _optionTitles = @[@[@"动画方式",
                            @[@"translation",
                              @"scale",
                              @"rotation",
                              @"alpha",
                              @"backgroundColor",
                              @"keyframe"]],
                          @[@"单视图过渡效果",
                            @[@"none",
                              @"flipFromLeft",
                              @"flipFromRight",
                              @"curlUp",
                              @"curlDown",
                              @"crossDissolve",
                              @"flipFromTop",
                              @"flipFromBottom"]],
                          @[@"双视图转场效果",
                            @[@"none",
                              @"flipFromLeft",
                              @"flipFromRight",
                              @"curlUp",
                              @"curlDown",
                              @"crossDissolve",
                              @"flipFromTop",
                              @"flipFromBottom"]]];
    }
    
    return _optionTitles;
}

- (NSMutableArray *)images
{
    if (_images == nil)
    {
        _images = [@[[UIImage imageNamed:@"webchat"], [UIImage imageNamed:@"qq"]] mutableCopy];
    }
    
    return _images;
}

@end