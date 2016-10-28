//
//  FoodViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodDetailViewController.h"


@interface FoodViewController (){
    UIActivityIndicatorView *activity;
}
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSString *strUrl;
@end

@implementation FoodViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeFood];
        self.title=@"美食";
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
    // Do any additional setup after loading the view.
    [self getRequest];
    [self test];
}

-(void)getRequest{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];;
    NSDictionary *paramters =@{@"tag":@"food",@"max_behot_time":@"1447553569",@"cound":@"20",@"uuid":@"99000549336277"};
    [manager GET:@"http://i.snssdk.com/gallery/1/recent/" parameters:paramters success:^(AFHTTPRequestOperation *operation,id responseObject){
        [self initView];
        self.dataArray=[responseObject valueForKey:@"data"];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
    }];
}
-(void)test{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];;
    NSDictionary *parmaters=@{@"ion":@"120.159957",@"sort":@"default",@"format":@"json"};
    [manager POST:@"http://api.meishi.cc/v5/zt.php" parameters:parmaters success:^(AFHTTPRequestOperation *operation,id responseObject){
    
        NSLog(@"reasss==%@",responseObject);
    
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"error");
    
    
    }];
}
-(void)initView{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"food" bundle:nil] forCellWithReuseIdentifier:@"food"];
    flowLayout.minimumInteritemSpacing=1;
    flowLayout.minimumLineSpacing=1;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"food" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    NSURL *url = [NSURL URLWithString:self.dataArray[indexPath.row][@"large_url"]];
    [imageView setImageWithURL:url];
    
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((P_Width-10)/2, 167);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 4, 4);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *bacBtn = [[UIBarButtonItem alloc] init];
    bacBtn.title=@"";
    self.navigationItem.backBarButtonItem=bacBtn;
    FoodDetailViewController *food = [FoodDetailViewController new];
    food.strUrl=self.dataArray[indexPath.row][@"share_url"];
    [self.navigationController pushViewController:food animated:YES];

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
