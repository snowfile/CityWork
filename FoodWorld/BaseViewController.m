//
//  BaseViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark --个性化配置
-(void)configTabbarItemWithTabbarItemMode:(KTabbarItemMode)tabbarItemMode{
    switch (tabbarItemMode) {
        case KTabbarItemModeFood:
            [self configTabbaritemWithTitle:@"美食" normalImageName:@"food"];
            break;
        case KTabbarItemModeVedio:
            [self configTabbaritemWithTitle:@"热点" normalImageName:@"vedio"];
            break;
        case KTabbarItemModeNews:
            [self configTabbaritemWithTitle:@"资讯" normalImageName:@"news"];
            break;
        case KTabbarItemModeMore:
            [self configTabbaritemWithTitle:@"更多" normalImageName:@"more"];
            break;
        default:
            break;
    }
}
#pragma mark - 为不同的界面，配置tabbarItem
/*
 * 为不同的界面，配置tabbarItem
 * @param title             标签的题目
 * @param normalImageName   未被选中时显示的图片
 * @param selectedImageName 被选中时显示的图片
 */

-(void)configTabbaritemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName{

    UIImage *normalImage = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:nil];
    //更改title的位置
    [tabbarItem setTitlePositionAdjustment:UIOffsetMake(0, 2)];
    //更改title的字体大小
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    self.tabBarItem=tabbarItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
