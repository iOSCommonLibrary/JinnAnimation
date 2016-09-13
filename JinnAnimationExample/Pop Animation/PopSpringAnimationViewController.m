/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: PopSpringAnimationViewController.m
 **  Description: PopSpringAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "PopSpringAnimationViewController.h"
#import "Pop.h"

@interface PopSpringAnimationViewController () <UITableViewDataSource, UITableViewDelegate, POPAnimationDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation PopSpringAnimationViewController

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

- (void)translationAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    // [animation setFromValue:[NSValue valueWithCGPoint:CGPointZero]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(0, -100)]];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"translationAnimation"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)]];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)rotationAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(M_PI, M_PI)]];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)opacityAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:@(0)];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"opacityAnimation"];
}

- (void)boundsAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:[NSValue valueWithCGRect:CGRectZero]];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"boundsAnimation"];
}

- (void)backgroundColorAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:(id)([UIColor brownColor].CGColor)];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"backgroundColorAnimation"];
}

- (void)cornerRadiusAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    [animation setSpringBounciness:30];
    [animation setSpringSpeed:10];
    [animation setToValue:@(70)];
    [animation setRoundingFactor:0];
    [animation setClampMode:kPOPAnimationClampNone];
    [animation setAdditive:NO];
    [animation setBeginTime:CACurrentMediaTime() + 0];
    [animation setDelegate:self];
    [animation setRemovedOnCompletion:YES];
    [animation setPaused:YES];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:0];
    [animation setRepeatForever:NO];
    [self.imageView.layer pop_addAnimation:animation forKey:@"cornerRadiusAnimation"];
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
    static NSString *idendifier = @"PopSpringAnimationTableViewCell";
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
                              @"cornerRadius"]]];
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