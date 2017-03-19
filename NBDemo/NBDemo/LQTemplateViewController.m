//
//  LQTemplateViewController.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQTemplateViewController.h"

#import "LQTemplateLayout.h"
#import "LQCollectionViewCell.h"
#import "LQLayoutDefine.h"

#import "LQSelectView.h"

@interface LQTemplateViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LQSelectViewDelegate>

@property(nonatomic, strong) NSArray<__kindof LQTemplateLayout *> *templateLayouts;

@property(nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *itemID = @"itemID";

@implementation LQTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"模板选择";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _templateLayouts = [LQTemplateLayout itemTemplateLayout];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 370) collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[LQCollectionViewCell class] forCellWithReuseIdentifier:itemID];
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    LQSelectView *selectView = [[LQSelectView alloc]initWithFrame:CGRectMake(0, 500, self.view.bounds.size.width, 220)];
    [self.view addSubview:selectView];
    [selectView creatView];
    
    selectView.delegate = self;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _templateLayouts.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull LQCollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    cell.templateLayout = _templateLayouts[indexPath.row];
}

#pragma mark --- LQSelectViewDelegate
-(void)btnClickWithEnum:(MyEnum)myenum {
    if (myenum == MyEnumValueA) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else if (myenum == MyEnumValueB) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else if (myenum == MyEnumValueC) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}


@end
