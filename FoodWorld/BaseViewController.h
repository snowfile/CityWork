//
//  BaseViewController.h
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,KTabbarItemMode) {


    KTabbarItemModeFood,//美食
    KTabbarItemModeVedio,//视频
    KTabbarItemModeNews,//资讯
    KTabbarItemModeMore,//更多

};
@interface BaseViewController : UIViewController
//个性配置tabbbarItem
-(void)configTabbarItemWithTabbarItemMode:(KTabbarItemMode)tabbarItemMode;
/**
 *为不同的界面配置tabarItem
 *@param title  标签的题目
 *@param normalImageName 未被选中时的图片
 *@param selectedImageName 被选中时选中的图片
 *
 **/

-(void)configTabbaritemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName;


@end
