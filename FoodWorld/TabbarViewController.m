//
//  TabbarViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "TabbarViewController.h"
#import "MediaViewController.h"

@interface TabbarViewController (){

    UITableView *moreView;
    BOOL isShow;
    UIView *aView;

}
@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
}
-(void)initTabbar{
    aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, P_Height)];
    aView.backgroundColor = [UIColor lightTextColor];
    aView.alpha=0.5;
    aView.hidden=YES;
    [self.view addSubview:aView];
   

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aviewShowOrNot)];
    singleTap.numberOfTouchesRequired=1;
    singleTap.numberOfTapsRequired=1;
    aView.userInteractionEnabled=YES;
    [aView addGestureRecognizer:singleTap];
    
    
    self.tabBar.barTintColor=[UIColor colorWithRed:0.6 green:0.79 blue:0.4 alpha:1];
    self.tabBar.translucent=NO;
    
    UIButton *buttonAdd = [[UIButton alloc] init];
    [buttonAdd setBackgroundImage:[UIImage imageNamed:@"add"]  forState:UIControlStateNormal];
    buttonAdd.frame=CGRectMake(P_Width/2-24, P_Height-44, 48, 44);
    [buttonAdd addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAdd];
    
    UIButton *moreBtn =[[ UIButton alloc] initWithFrame:CGRectMake(10, 28,30, 30)];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [self.view addSubview:moreBtn];
    
    UIButton *buttonLogin = [[UIButton alloc] initWithFrame:CGRectMake(P_Width-60, 15, 60, 60)];
    [buttonLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [self.view addSubview:buttonLogin];
   
    
    moreView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, 90, 210)];
    moreView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    moreView.hidden=YES;
    moreView.delegate=self;
    moreView.dataSource=self;
    moreView.scrollEnabled=NO;
    moreView.showsVerticalScrollIndicator=NO;
    isShow=NO;
    [self.view  addSubview:moreView];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    NSArray *array =@[@"关于",@"收藏",@"设置",@"喜爱",@"我的二维码"];
    NSArray *imagesArrays=@[@"about",@"collect",@"setup",@"like",@"myqr"];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(35, 5, 50, 20)];
    label.text=[array objectAtIndex:indexPath.row];
    label.textColor = [UIColor blackColor];
    label.font =[UIFont systemFontOfSize:8];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 20, 18)];
    imageView.image=[UIImage imageNamed:[imagesArrays objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:imageView];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:label];
    return cell;

}
-(void)moreBtnClick{
    if (isShow==NO) {
        isShow=YES;
        aView.hidden=YES;
        moreView.hidden=YES;
    }else{
        isShow=NO;
        aView.hidden=NO;
        moreView.hidden=NO;
    }
}
-(void)aviewShowOrNot{
    aView.hidden=YES;
    moreView.hidden=YES;
    isShow=NO;
}
-(void)addBtnClick{
   
    MediaViewController *media = [MediaViewController new];
    [media setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:media animated:YES completion:^{}];
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
