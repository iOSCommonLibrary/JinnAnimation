/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: CATransitionViewController.m
 **  Description: CATransition 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "CATransitionViewController.h"

static const CGFloat kAnimationDuration = 1.f;

@interface CATransitionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString       *subtype;
@property (nonatomic, strong) NSString       *mediaTimingFunctionName;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation CATransitionViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.optionTableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.optionTableView.layer.borderWidth = 1;
    self.optionTableView.dataSource = self;
    self.optionTableView.delegate = self;
    
    self.imageView.image = self.images[0];
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
    [self.images exchangeObjectAtIndex:0 withObjectAtIndex:1];
}

#pragma mark - Animation

- (void)transitionWithAnimationTransition:(NSString *)animationTransition
{
    CATransition *transition= [[CATransition alloc] init];
    [transition setType:animationTransition];
    [transition setSubtype:self.subtype];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [transition setDelegate:self];
    [transition setRemovedOnCompletion:YES];
    [transition setBeginTime:CACurrentMediaTime() + 0];
    [transition setDuration:kAnimationDuration];
    [transition setSpeed:1];
    [transition setTimeOffset:0];
    [transition setRepeatCount:0]; // 重复次数，无限循环可以设置 HUGE_VALF
    [transition setRepeatDuration:0];
    [transition setAutoreverses:NO];
    [transition setFillMode:kCAFillModeRemoved];
    [self.imageView setImage:self.images[1]];
    [self.imageView.layer addAnimation:transition forKey:@"CATransitionAnimation"];
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
    static NSString *idendifier = @"CATransitionTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    if ((indexPath.section == 1 && [self.optionTitles[indexPath.section][1][indexPath.row] isEqualToString:self.subtype]) ||
        (indexPath.section == 2 && [self.optionTitles[indexPath.section][1][indexPath.row] isEqualToString:self.mediaTimingFunctionName]))
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
    
    switch (indexPath.section)
    {
        case 0:
        {
            [self transitionWithAnimationTransition:title];
        }
            break;
        case 1:
        {
            [self setSubtype:title];
        }
            break;
        case 2:
        {
            [self setMediaTimingFunctionName:title];
        }
            break;
        default:
            break;
    }
    
    [self.optionTableView reloadData];
}

#pragma mark - Getter / Setter

- (NSArray *)optionTitles
{
    if (_optionTitles == nil)
    {
        _optionTitles = @[@[@"转场效果",
                            @[@"fade",
                              @"moveIn",
                              @"push",
                              @"reveal",
                              @"pageCurl",
                              @"pageUnCurl",
                              @"rippleEffect",
                              @"suckEffect",
                              @"cube",
                              @"oglFlip",
                              @"cameraIris"]],
                          @[@"转场方向",
                            @[@"fromRight",
                              @"fromLeft",
                              @"fromTop",
                              @"fromBottom"]],
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

- (NSString *)subtype
{
    if (_subtype == nil)
    {
        _subtype = kCATransitionFromRight;
    }
    
    return _subtype;
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