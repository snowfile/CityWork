//
//  NewsViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.

#import "NewsViewController.h"
#import "NewsDetailViewController.h"
@interface NewsViewController (){
    UIPageControl *pageControl;
    NSTimer *timer;
    NSArray *pageArray;
    UIActivityIndicatorView *activity;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arrayNews;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation NewsViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeNews];
        self.title=@"热点";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(P_Width/2-100, 200, 200, 200)];
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
-(void)getRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paraterms =@{@"format":@"json"};
    [manager GET:@"http://api.meishi.cc/v5/health_main.php" parameters:paraterms success:^(AFHTTPRequestOperation *operation ,id responseObject) {
        self.arrayNews=responseObject;
        pageArray=[responseObject valueForKey:@"top_imgs"];
        NSLog(@"answers====%ld",[[self.arrayNews valueForKey:@"list"] count]);
        [self initwithView];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
    }];
}
-(void)initwithView{
    self.tableView =[[ UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, P_Height)];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.dataSource=self;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 200)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 200)];
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.contentSize=CGSizeMake([[self.arrayNews  valueForKey:@"top_imgs"] count]*P_Width, 180);
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.tag=1001;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [topView addSubview:_scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(P_Width/2-100, 175, 200, 25)];
    pageControl.numberOfPages=[[self.arrayNews valueForKey:@"top_imgs"] count];
    pageControl.currentPageIndicatorTintColor=[UIColor blueColor];
    pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    pageControl.currentPage=0;
    [topView addSubview:pageControl];
    
    self.tableView.tableHeaderView=topView;
    [self.view addSubview:self.tableView];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}
//实现scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==1001) {
        int pageNumber =scrollView.contentOffset.x/scrollView.frame.size.width;
        pageControl.currentPage=pageNumber;
    }
}
#pragma mark 设置scrollView自动跳转
-(void)scrollToNextPage{
    long int pageNum=pageControl.currentPage;
    CGSize viewSize=_scrollView.frame.size;
    CGRect rect=CGRectMake((pageNum+1)*viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum==pageArray.count) {
        CGRect newRect=CGRectMake(0*viewSize.width, 0, viewSize.width, viewSize.height);
        [_scrollView scrollRectToVisible:newRect animated:NO];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}
//设置tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [[self.arrayNews valueForKey:@"list"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if (cell==nil) {
        cell = [[UITableViewCell alloc] init];
    }
    for (int i=0; i<[[self.arrayNews valueForKey:@"top_imgs"] count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*P_Width, 0, P_Width, 160)];
        NSURL *url =[NSURL URLWithString:[[[self.arrayNews valueForKey:@"top_imgs"] objectAtIndex:i] valueForKey:@"photo"]];
        NSLog(@"url==%@",url);
       [imageView setImageWithURL:url];
        [_scrollView addSubview:imageView];

    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 100, 98)];
    imageView.backgroundColor=[UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:[[[self.arrayNews valueForKey:@"list"] objectAtIndex:indexPath.row]  valueForKey:@"titlepic"]];
    [imageView setImageWithURL:url];
    [cell.contentView addSubview:imageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(104, 3, P_Width-108, 28)];
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.text=[[[self.arrayNews valueForKey:@"list"] objectAtIndex:indexPath.row] valueForKey:@"title"];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [cell.contentView addSubview:titleLabel];
    
    
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(104, 38, P_Width-108, 70)];
    descLabel.textColor=[UIColor lightGrayColor];
    descLabel.text=[[[self.arrayNews valueForKey:@"list"] objectAtIndex:indexPath.row] valueForKey:@"smalltext"];

    descLabel.numberOfLines=0;
    descLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:descLabel];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 102;
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
