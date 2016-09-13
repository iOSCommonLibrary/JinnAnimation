/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: CAKeyframeAnimationViewController.m
 **  Description: CAKeyframeAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "CAKeyframeAnimationViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface CAKeyframeAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString       *mediaTimingFunctionName;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation CAKeyframeAnimationViewController

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

#pragma mark - Animation

- (void)pathAnimation
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, self.imageView.center.x - 70, self.imageView.center.y, 70, 0, M_PI * 2, YES);
    CGPathAddLineToPoint(path, nil, self.imageView.center.x, self.imageView.center.y - 100);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
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
    [self.imageView.layer addAnimation:animation forKey:@"pathAnimation"];
    
    CFRelease(path);
}

- (void)keyTimesAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [animation setValues:@[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                           [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -60, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DIdentity],
                           [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 60, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DIdentity],
                           [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -60, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DIdentity],
                           [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 60, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DIdentity]]];
    [animation setKeyTimes:@[@(0/9.f), @(1/9.f), @(2/9.f), @(3/9.f), @(4/9.f), @(5/9.f), @(6/9.f), @(7/9.f), @(8/9.f)]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDuration:kAnimationDuration];
    [animation setSpeed:1];
    [animation setTimeOffset:0];
    [animation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [animation setRepeatDuration:0];
    [animation setAutoreverses:NO];
    [animation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:animation forKey:@"keyTimesAnimation"];
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
    static NSString *idendifier = @"CAKeyframeAnimationTableViewCell";
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
    
    if ([title isEqualToString:@"path"])
    {
        [self pathAnimation];
    }
    else if ([title isEqualToString:@"keyTimes"])
    {
        [self keyTimesAnimation];
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
                            @[@"path",
                              @"keyTimes"]],
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