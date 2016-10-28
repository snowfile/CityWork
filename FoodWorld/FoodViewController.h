//
//  FoodViewController.h
//  FoodWorld
//
//  Created by Neuedu on 15/11/28.
//  Copyright © 2015年 Neuedu. All rights reserved.
//

#import "BaseViewController.h"

@interface FoodViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@end
