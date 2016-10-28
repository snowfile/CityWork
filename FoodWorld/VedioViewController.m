//
//  VedioViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "VedioViewController.h"
#import "NewsViewController.h"
@interface VedioViewController (){

    UISegmentedControl *segmentControl;
    UIActivityIndicatorView  *activity;
}
@property(nonatomic,strong)UITableView *foodTableView;
@property(nonatomic,strong)NSArray *vedioDict;
@property(nonatomic,strong)UIView *childView;
@end

@implementation VedioViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeVedio];
        self.title=@"视频";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(P_Width/2-100, 250, 200, 200)];
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activity.color = [UIColor blueColor];
    [activity startAnimating];
    [self.view addSubview:activity];
}
-(void)viewDidAppear:(BOOL)animated{

    [activity stopAnimating];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRequest];
}
//-----------------读取自定义json数据--------------------------------------------
-(void)getRequest{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"foodVideo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [self initTableView];
    self.vedioDict =dict[@"data"];
    NSLog(@"%@",self.vedioDict);
    
}
-(void)initTableView{
    self.foodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, P_Height-65)];
    self.foodTableView.delegate=self;
    self.foodTableView.dataSource =self;
    [self.view addSubview:self.foodTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.vedioDict count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell= [[UITableViewCell alloc] init];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 120, 100)];
    NSURL *url = [NSURL URLWithString:self.vedioDict[indexPath.row][@"titlepic"]];
    [imageView setImageWithURL:url];
    imageView.backgroundColor= [UIColor whiteColor];
    [cell.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 2, 120, 30)];
    label.text=self.vedioDict[indexPath.row][@"title"];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:label];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 38, P_Width-130, 30)];
    NSString *str=@"步";
    str =[str stringByAppendingString:self.vedioDict[indexPath.row][@"mt"]];
    descLabel.text=[self.vedioDict[indexPath.row][@"step"] stringByAppendingString:str];
    descLabel.textColor= [UIColor lightGrayColor];
    descLabel.font =[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:descLabel];
    UILabel *detail =[[UILabel alloc] initWithFrame:CGRectMake(130, 70, P_Width-130, 25)];
    detail.text=self.vedioDict[indexPath.row][@"kouwei"];
    detail.textColor= [UIColor grayColor];
    detail.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:detail];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;

}
-(void)didReceiveMemoryWarning {
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
