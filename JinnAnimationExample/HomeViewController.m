/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: HomeViewController.m
 **  Description: iOS 动画总结目录
 **
 **  Author:  jinnchang
 **  Date:    16/9/9
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "HomeViewController.h"

#import "UIGravityBehaviorViewController.h"
#import "UICollisionBehaviorViewController.h"
#import "UIAttachmentBehaviorViewController.h"
#import "UISnapBehaviorViewController.h"
#import "UIPushBehaviorViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation HomeViewController

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section][1] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titles[section][0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifier = @"HomeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idendifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titles[indexPath.section][1][indexPath.row][0];
    cell.detailTextLabel.text = self.titles[indexPath.section][1][indexPath.row][1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = nil;
    UIViewController *viewController = nil;
    NSString *title = self.titles[indexPath.section][1][indexPath.row][0];
    
    if (indexPath.section == 0)
    {
        storyboard = [UIStoryboard storyboardWithName:@"UIViewAnimation" bundle:nil];
    }
    else if (indexPath.section == 1)
    {
        storyboard = [UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil];
    }
    else if (indexPath.section == 2)
    {
        storyboard = [UIStoryboard storyboardWithName:@"PopAnimation" bundle:nil];
    }
    
    if (indexPath.section == 3)
    {
        if ([title isEqualToString:@"UIGravityBehavior"]) // 重力行为
        {
            viewController = [[UIGravityBehaviorViewController alloc] init];
        }
        else if ([title isEqualToString:@"UICollisionBehavior"]) // 碰撞行为
        {
            viewController = [[UICollisionBehaviorViewController alloc] init];
        }
        else if ([title isEqualToString:@"UIAttachmentBehavior"]) // 连接行为
        {
            viewController = [[UIAttachmentBehaviorViewController alloc] init];
        }
        else if ([title isEqualToString:@"UISnapBehavior"]) // 吸附行为
        {
            viewController = [[UISnapBehaviorViewController alloc] init];
        }
        else if ([title isEqualToString:@"UIPushBehavior"]) // 推动行为
        {
            viewController = [[UIPushBehaviorViewController alloc] init];
        }
    }
    else
    {
        viewController = [storyboard instantiateViewControllerWithIdentifier:title];
    }
    
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Getter / Setter

- (NSArray *)titles
{
    if (_titles == nil)
    {
        _titles = @[@[@"UIView Animation", @[@[@"UIViewBasicAnimation", @"动画演示"],
                                             @[@"UIViewBlockAnimation", @"动画演示"]]],
                    @[@"Core Animation", @[@[@"CABasicAnimation", @"动画演示"],
                                           @[@"CAKeyframeAnimation", @"动画演示"],
                                           @[@"CAAnimationGroup", @"动画演示"],
                                           @[@"CATransition", @"动画演示"]]],
                    @[@"Pop Animation", @[@[@"PopBasicAnimation", @"动画演示"],
                                          @[@"PopSpringAnimation", @"动画演示"],
                                          @[@"PopDecayAnimation", @"动画演示"],
                                          @[@"PopCustomAnimation", @"动画演示"]]],
                    @[@"Dynamic Animator", @[@[@"UIGravityBehavior", @"重力行为"],
                                             @[@"UICollisionBehavior", @"碰撞行为"],
                                             @[@"UIAttachmentBehavior", @"连接行为"],
                                             @[@"UISnapBehavior", @"吸附行为"],
                                             @[@"UIPushBehavior", @"推动行为"]]]];
    }
    
    return _titles;
}

@end