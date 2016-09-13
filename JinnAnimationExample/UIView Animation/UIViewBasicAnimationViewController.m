/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: UIViewBasicAnimationViewController.m
 **  Description: UIViewBasicAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "UIViewBasicAnimationViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface UIViewBasicAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray              *optionTitles;
@property (nonatomic, strong) NSMutableArray       *images;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign) BOOL                 animated;

@end

@implementation UIViewBasicAnimationViewController

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
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [self.imageView setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}

- (void)scaleAnimation
{
    [self.imageView setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [self.imageView setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}

- (void)rotationAnimation
{
    [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [self.imageView setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}

- (void)alphaAnimation
{
    [self.imageView setAlpha:0];
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [self.imageView setAlpha:1];
    [UIView commitAnimations];
}

- (void)backgroundColorAnimation
{
    [self.imageView setBackgroundColor:[UIColor brownColor]];
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [self.imageView setBackgroundColor:[UIColor yellowColor]];
    [UIView commitAnimations];
}

- (void)transitionWithAnimationTransition:(UIViewAnimationTransition)animationTransition
{
    [self.imageView setImage:self.images[0]];
    
    // 动画前后分割线
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart)];
    [UIView setAnimationDidStopSelector:@selector(transitionDidFinish)];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationsEnabled:YES];
    [UIView setAnimationTransition:animationTransition forView:self.imageView cache:NO];
    [self.imageView setImage:self.images[1]];
    [UIView commitAnimations];
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
    static NSString *idendifier = @"UIViewBasicAnimationTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    if (indexPath.section == 2 && indexPath.row == self.animationCurve)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    else if ([title isEqualToString:@"none"])
    {
        [self transitionWithAnimationTransition:UIViewAnimationTransitionNone];
    }
    else if ([title isEqualToString:@"flipFromLeft"])
    {
        [self transitionWithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
    }
    else if ([title isEqualToString:@"flipFromRight"])
    {
        [self transitionWithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
    }
    else if ([title isEqualToString:@"curlUp"])
    {
        [self transitionWithAnimationTransition:UIViewAnimationTransitionCurlUp];
    }
    else if ([title isEqualToString:@"curlDown"])
    {
        [self transitionWithAnimationTransition:UIViewAnimationTransitionCurlDown];
    }
    else if ([title isEqualToString:@"easeInOut"])
    {
        [self setAnimationCurve:UIViewAnimationCurveEaseInOut];
    }
    else if ([title isEqualToString:@"easeIn"])
    {
        [self setAnimationCurve:UIViewAnimationCurveEaseIn];
    }
    else if ([title isEqualToString:@"easeOut"])
    {
        [self setAnimationCurve:UIViewAnimationCurveEaseOut];
    }
    else if ([title isEqualToString:@"linear"])
    {
        [self setAnimationCurve:UIViewAnimationCurveLinear];
    }
    
    [self.optionTableView reloadData];
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
                              @"backgroundColor"]],
                          @[@"单视图过渡效果",
                            @[@"none",
                              @"flipFromLeft",
                              @"flipFromRight",
                              @"curlUp",
                              @"curlDown"]],
                          @[@"动画曲线",
                            @[@"easeInOut",
                              @"easeIn",
                              @"easeOut",
                              @"linear"]]];
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