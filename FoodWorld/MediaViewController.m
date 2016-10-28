//
//  MediaViewController.m
//  FoodWorld
//
//  Created by Neuedu on 15/12/4.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "MediaViewController.h"

@interface MediaViewController ()
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, P_Height-300, P_Width, 300) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    flowLayout.minimumInteritemSpacing=20;
    flowLayout.minimumLineSpacing=20;
    [self.collectionView registerNib:[UINib nibWithNibName:@"add" bundle:nil] forCellWithReuseIdentifier:@"add"];
    [self.view addSubview:self.collectionView];

    
    UIView *bottonView = [[UIView alloc] initWithFrame:CGRectMake(0, P_Height-40, P_Width, 40)];
    bottonView.backgroundColor=[UIColor whiteColor];
    bottonView.alpha=1;
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(P_Width/2-15, 2,30, 25)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"folk"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottonView addSubview:btnBack];
    [self.view addSubview:bottonView];

}
-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imagesArray =@[@"add1",@"add2",@"add3",@"add4",@"add5",@"add6"];
    NSArray *namesArray =@[@"文字",@"照片",@"微博",@"消息",@"视频",@"分享"];

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
    imageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text=[namesArray objectAtIndex:indexPath.row];
    label.textColor=[UIColor blackColor];
    NSLog(@"text==%@",label.text);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:13];
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((P_Width-80)/3, 85);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
    
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
