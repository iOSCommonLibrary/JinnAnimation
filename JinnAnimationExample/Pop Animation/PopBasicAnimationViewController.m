/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: PopBasicAnimationViewController.m
 **  Description: PopBasicAnimation 动画演示
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "PopBasicAnimationViewController.h"
#import "Pop.h"

static const CGFloat kAnimationDuration = 1.f;

@interface PopBasicAnimationViewController () <UITableViewDataSource, UITableViewDelegate, POPAnimationDelegate>

@property (weak, nonatomic) IBOutlet UITableView             *optionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView             *imageView;

@property (nonatomic, strong) NSArray        *optionTitles;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString       *mediaTimingFunctionName;
@property (nonatomic, assign) BOOL           animated;

@end

@implementation PopBasicAnimationViewController

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

#pragma mark - POPAnimatableProperty

// backgroundColor
// bounds
// cornerRadius
// borderWidth
// borderColor
// opacity
// position
// positionX
// positionY
// rotation
// rotationX
// rotationY
// scaleX
// scaleXY
// scaleY
// size
// subscaleXY
// subtranslationX
// subtranslationXY
// subtranslationY
// subtranslationZ
// translationX
// translationXY
// translationY
// translationZ
// zPosition
// shadowColor
// shadowOffset
// shadowOpacity
// shadowRadius

#pragma mark - Animation

- (void)translationAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    // [animation setFromValue:[NSValue valueWithCGPoint:CGPointZero]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(-100, -100)]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBounds];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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

- (void)borderColorAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBorderColor];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setToValue:(id)([UIColor redColor].CGColor)];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"borderColorAnimation"];
}

- (void)borderWidthAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"borderWidthAnimation"];
}

- (void)shadowColorAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowColor];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setToValue:(id)([UIColor redColor].CGColor)];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"shadowColorAnimation"];
}

- (void)shadowOffsetAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowOffset];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(12, 12)]];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"shadowOffsetAnimation"];
}

- (void)shadowRadiusAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowRadius];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
    [animation setToValue:@(30)];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"shadowRadiusAnimation"];
}

- (void)shadowOpacityAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
    [animation setDuration:kAnimationDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName]];
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
    [self.imageView.layer pop_addAnimation:animation forKey:@"shadowOpacityAnimation"];
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
    static NSString *idendifier = @"PopBasicAnimationTableViewCell";
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