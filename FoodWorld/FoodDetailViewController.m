//
//  FoodDetailViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/30.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "FoodDetailViewController.h"

@interface FoodDetailViewController ()
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation FoodDetailViewController
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden=YES;
//    [UIApplication sharedApplication].statusBarHidden=YES;
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden=NO;
//    [UIApplication sharedApplication].statusBarHidden=NO;
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initwithWebView];
   
}
-(void)initwithWebView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, P_Width, P_Height)];
    NSURL *url= [NSURL URLWithString:self.strUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];


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
