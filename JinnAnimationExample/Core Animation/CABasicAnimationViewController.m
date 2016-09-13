/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: CABasicAnimationViewController.m
 **  Description: CABasicAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "CABasicAnimationViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface CABasicAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString       *mediaTimingFunctionName;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation CABasicAnimationViewController

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
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(3, 3);
    self.imageView.layer.shadowRadius = 3;
    self.imageView.layer.shadowOpacity = 0.8;
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

#pragma mark - CALayer Animatable Property

// anchorPoint
// backgroundColor
// backgroundFilters
// borderColor
// borderWidth
// bounds
// compositingFilter
// contents
// contentsRect
// cornerRadius
// doubleSided
// filters
// frame
// hidden
// mask
// masksToBounds
// opacity
// position
// shadowColor
// shadowOffset
// shadowOpacity
// shadowPath
// shadowRadius
// sublayers
// sublayerTransform
// transform
// zPosition

#pragma mark - Animation

- (void)translationAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform"];
    // [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -100, 0)]];
    // [animation setByValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -100, 0)]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"translationAnimation"];
}

- (void)scaleAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform"];
    [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.5)]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)rotationAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform"];
    [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.5, 0.5, 0.5)]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)opacityAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setToValue:@(0)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

- (void)boundsAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"bounds"];
    [animation setToValue:[NSValue valueWithCGRect:CGRectZero]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"boundsAnimation"];
}

- (void)backgroundColorAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [animation setToValue:(id)([UIColor brownColor].CGColor)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"backgroundColorAnimation"];
}

- (void)cornerRadiusAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    [animation setToValue:@(70)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeForwards];
    [self.imageView.layer addAnimation:animation forKey:@"cornerRadiusAnimation"];
}

- (void)borderColorAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"borderColor"];
    [animation setToValue:(id)([UIColor redColor].CGColor)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"borderColorAnimation"];
}

- (void)borderWidthAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    [animation setToValue:@(70)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"borderWidthAnimation"];
}

- (void)shadowColorAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"shadowColor"];
    [animation setToValue:(id)([UIColor redColor].CGColor)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"shadowColorAnimation"];
}

- (void)shadowOffsetAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    [animation setToValue:[NSValue valueWithCGSize:CGSizeMake(12, 12)]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"shadowOffsetAnimation"];
}

- (void)shadowRadiusAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    [animation setToValue:@(30)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"shadowRadiusAnimation"];
}

- (void)shadowOpacityAnimation
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    [animation setToValue:@(0)];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:YES];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"shadowOpacityAnimation"];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    [self animationDidStart];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self animationDidFinish];
    }
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
    static NSString *idendifier = @"CABasicAnimationTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    if (indexPath.section == 1 && [self.optionTitles[indexPath.section][1][indexPath.row] isEqualToString:self.mediaTimingFunctionName])
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
    else if ([title isEqualToString:@"opacity"])
    {
        [self opacityAnimation];
    }
    else if ([title isEqualToString:@"bounds"])
    {
        [self boundsAnimation];
    }
    else if ([title isEqualToString:@"backgroundColor"])
    {
        [self backgroundColorAnimation];
    }
    else if ([title isEqualToString:@"cornerRadius"])
    {
        [self cornerRadiusAnimation];
    }
    else if ([title isEqualToString:@"borderColor"])
    {
        [self borderColorAnimation];
    }
    else if ([title isEqualToString:@"borderWidth"])
    {
        [self borderWidthAnimation];
    }
    else if ([title isEqualToString:@"shadowColor"])
    {
        [self shadowColorAnimation];
    }
    else if ([title isEqualToString:@"shadowOffset"])
    {
        [self shadowOffsetAnimation];
    }
    else if ([title isEqualToString:@"shadowRadius"])
    {
        [self shadowRadiusAnimation];
    }
    else if ([title isEqualToString:@"shadowOpacity"])
    {
        [self shadowOpacityAnimation];
    }
    else if (indexPath.section == 1)
    {
        [self setMediaTimingFunctionName:title];
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
                              @"opacity",
                              @"bounds",
                              @"backgroundColor",
                              @"cornerRadius",
                              @"borderColor",
                              @"borderWidth",
                              @"shadowColor",
                              @"shadowOffset",
                              @"shadowRadius",
                              @"shadowOpacity"]],
                          @[@"动画曲线",
                            @[@"linear",
                              @"easeIn",
                              @"easeOut",
                              @"easeInEaseOut",
                              @"default"]]];
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

- (NSString *)mediaTimingFunctionName
{
    if (_mediaTimingFunctionName == nil)
    {
        _mediaTimingFunctionName = kCAMediaTimingFunctionDefault;
    }
    
    return _mediaTimingFunctionName;
}

@end