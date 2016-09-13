/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: CAAnimationGroupViewController.m
 **  Description: CAAnimationGroup 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "CAAnimationGroupViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface CAAnimationGroupViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString       *mediaTimingFunctionName;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation CAAnimationGroupViewController

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

#pragma mark - Animation

- (void)groupAnimation
{
    CABasicAnimation *scaleAnimation= [CABasicAnimation animationWithKeyPath:@"transform"];
    [scaleAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)]];
    [scaleAnimation setDuration:kAnimationDuration];
    [self.imageView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    CABasicAnimation *rotationAnimation= [CABasicAnimation animationWithKeyPath:@"transform"];
    [rotationAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 0.5)]];
    [rotationAnimation setDuration:kAnimationDuration];
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    CABasicAnimation *backgroundColorAnimation= [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [backgroundColorAnimation setToValue:(id)([UIColor brownColor].CGColor)];
    [backgroundColorAnimation setDuration:kAnimationDuration];
    [self.imageView.layer addAnimation:backgroundColorAnimation forKey:@"backgroundColorAnimation"];
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    [groupAnimation setAnimations:@[scaleAnimation, rotationAnimation, backgroundColorAnimation]];
    [groupAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [groupAnimation setDelegate:self];
    [groupAnimation setRemovedOnCompletion:YES];
    [groupAnimation setBeginTime:CACurrentMediaTime() + 0];
    [groupAnimation setDuration:kAnimationDuration];
    [groupAnimation setSpeed:1];
    [groupAnimation setTimeOffset:0];
    [groupAnimation setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [groupAnimation setRepeatDuration:0];
    [groupAnimation setAutoreverses:YES];
    [groupAnimation setFillMode:kCAFillModeRemoved];
    [self.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
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
    static NSString *idendifier = @"CAAnimationGroupTableViewCell";
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
    
    if ([title isEqualToString:@"group"])
    {
        [self groupAnimation];
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
                            @[@"group"]],
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