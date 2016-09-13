/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: PopCustomAnimationViewController.m
 **  Description: PopCustomAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "PopCustomAnimationViewController.h"
#import "Pop.h"

static const CGFloat kAnimationDuration = 5.f;

@interface PopCustomAnimationViewController () <UITableViewDataSource, UITableViewDelegate, POPAnimationDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel                 *timeLabel;

@property (nonatomic, strong) NSArray *optionTitles;
@property (nonatomic, assign) BOOL    animated;

@end

@implementation PopCustomAnimationViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.optionTableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.optionTableView.layer.borderWidth = 1;
    self.optionTableView.dataSource = self;
    self.optionTableView.delegate = self;
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

- (void)countDownAnimation
{
    POPAnimatableProperty *countDownProperty =
    [POPAnimatableProperty propertyWithName:@"countDown"
                                initializer:^(POPMutableAnimatableProperty *prop) {
                                    prop.writeBlock = ^(id obj, const CGFloat values[]) {
                                        [(UILabel *)obj setText:[NSString stringWithFormat:@"%02d:%02d:%02d",
                                                                 (int)values[0] / 60,
                                                                 (int)values[0] % 60,
                                                                 (int)(values[0] * 100) % 100]];
                                    };
                                }];
    
    POPBasicAnimation *animation = [POPBasicAnimation linearAnimation];
    [animation setProperty:countDownProperty];
    [animation setDuration:kAnimationDuration];
    [animation setFromValue:@(kAnimationDuration)];
    [animation setToValue:@(0)];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.timeLabel pop_addAnimation:animation forKey:@"countDownAnimation"];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidStart:(POPAnimation *)anim
{
    [self animationDidStart];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if (finished)
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
    static NSString *idendifier = @"PopCustomAnimationTableViewCell";
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
    
    if ([self.optionTitles[indexPath.section][1][indexPath.row] isEqualToString:@"countDown"])
    {
        [self countDownAnimation];
    }
}

#pragma mark - Getter / Setter

- (NSArray *)optionTitles
{
    if (_optionTitles == nil)
    {
        _optionTitles = @[@[@"动画方式", @[@"countDown"]]];
    }
    
    return _optionTitles;
}

@end