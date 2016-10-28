//
//  NewsNaviViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "NewsNaviViewController.h"
#import "NewsViewController.h"

@interface NewsNaviViewController ()

@end

@implementation NewsNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customMakeNavigationBar];
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    if ([super init]) {
        NewsViewController *news = [NewsViewController new];
        self =[super initWithRootViewController:news];
    }
    return self;
}

-(void)customMakeNavigationBar{
    self.navigationBar.barTintColor=[UIColor colorWithRed:0.6 green:0.79 blue:0.4 alpha:1];
    self.navigationBar.translucent=NO;
    
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
