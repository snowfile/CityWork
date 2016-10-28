//
//  AppDelegate.h
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"
#import "FoodNaviViewController.h"
#import "AddNaviViewController.h"
#import "NewsNaviViewController.h"
#import "VedioNaviViewController.h"
#import "MoreNaviViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong,nonatomic)TabbarViewController *tabbarViewController;
@property (strong, nonatomic) UIWindow *window;


@end

