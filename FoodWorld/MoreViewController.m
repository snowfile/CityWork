//
//  MoreViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController (){
    UIPageControl *pageControl;
    NSDictionary *dict;
    NSTimer *timer;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *arrayPic;
@property(nonatomic,strong)UIScrollView *scrollView;

@end
@implementation MoreViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeMore];
        self.title=@"更多";
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTopView];
    [self initOtherView];
}
-(void)initTopView{
    UICollectionViewFlowLayout *flowyout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 160, P_Width, 200) collectionViewLayout:flowyout];
    flowyout.minimumInteritemSpacing=2;
    flowyout.minimumLineSpacing=1;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"more" bundle:nil] forCellWithReuseIdentifier:@"more"];
    [self.view addSubview:self.collectionView];
}
-(void)initOtherView{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"more" ofType:@"json"];
    NSData *data =[NSData dataWithContentsOfFile:path];
    dict =[ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.arrayPic=[dict valueForKey:@"huodong_list"];
    NSLog(@"data===%@",[dict valueForKey:@"huodong_list"]);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 330, P_Width, 120)];
    _scrollView.contentSize=CGSizeMake(P_Width, [[dict valueForKey:@"huodong_list"] count]*120);
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.tag=1001;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(P_Width/2-100, 175, 200, 25)];
    pageControl.numberOfPages=[[dict valueForKey:@"huodong_list"] count];
    pageControl.currentPageIndicatorTintColor=[UIColor clearColor];
    pageControl.pageIndicatorTintColor=[UIColor clearColor];
    pageControl.currentPage=0;
    [self.view addSubview:pageControl];
    
    for (int i=0; i<[[dict valueForKey:@"huodong_list"] count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*120, P_Width, 120)];
        NSURL *url = [NSURL URLWithString:self.arrayPic[i][@"img"][@"small"]];
        [imageView setImageWithURL:url];
        [_scrollView addSubview:imageView];
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];


    UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, P_Width/2-20, P_Height-410)];
    firstBtn.backgroundColor=[UIColor redColor];
    //去掉点击button时候的阴影属性
    firstBtn.adjustsImageWhenHighlighted=NO;
    [firstBtn setBackgroundImage:[UIImage imageNamed:@"food_More1"] forState:UIControlStateNormal];
    [self.view addSubview:firstBtn];
    
    
    UIButton *secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(P_Width/2-20, 5, P_Width/2+20, (P_Height-410)/2)];
    secondBtn.adjustsImageWhenHighlighted=NO;
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"food_More3"] forState:UIControlStateNormal];
    secondBtn.backgroundColor= [UIColor greenColor];
    [self.view addSubview:secondBtn];
    
    
    UIButton *thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(P_Width/2-20, 5+(P_Height-410)/2,P_Width/2+20, (P_Height-410)/2)];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"food_More2"] forState:UIControlStateNormal];
    thirdBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:thirdBtn];
    
}
//实现scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==1001) {
        int pageNumber =scrollView.contentOffset.y/scrollView.frame.size.height;
        pageControl.currentPage=pageNumber;
    }
}
#pragma mark 设置scrollView自动跳转
-(void)scrollToNextPage{
    long int pageNum=pageControl.currentPage;
    CGSize viewSize=_scrollView.frame.size;
    CGRect rect=CGRectMake(0, (pageNum+1)*viewSize.height, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum==[[dict valueForKey:@"huodong_list"] count]) {
        CGRect newRect=CGRectMake(0, 0*viewSize.height, viewSize.width, viewSize.height);
        [_scrollView scrollRectToVisible:newRect animated:NO];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"more" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    //设置图片和文字数组
    NSArray *imagesArray =@[@"more1",@"more2",@"more3",@"more4",@"more5",@"more6",@"more7",@"more8"];
    NSArray *labelArray =@[@"新菜谱",@"妈妈派",@"热菜",@"烘培",@"菜单",@"家常菜",@"健康",@"食材"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image=[UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.font = [UIFont systemFontOfSize:12];
    label.text=[labelArray objectAtIndex:indexPath.row];
    label.textAlignment=NSTextAlignmentCenter ;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((P_Width-64)/4, 85);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 5);
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
