//
//  LQTestViewController.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/19.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQTestViewController.h"

#import "LQTemplateLayout.h"
#import "LQLayoutDefine.h"
#import "LQTemplateView.h"
#import "LQSelectView.h"

@interface LQTestViewController ()<LQSelectViewDelegate>

@property(nonatomic, strong) NSArray<__kindof LQTemplateLayout *> *templateLayouts;

@property(nonatomic, strong) LQTemplateView *templateView;

@end

@implementation LQTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"模板选择";
    
    [self setupSubview];
    
}

-(void)setupSubview {
    
    self.templateLayouts = [LQTemplateLayout itemTemplateLayout];
    
    self.templateView = [[LQTemplateView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 375)];
    
    [self.view addSubview:self.templateView];
    //初始化展示模板
    self.templateView.templateLayout = [self.templateLayouts firstObject];
    
    LQSelectView *selectView = [[LQSelectView alloc]initWithFrame:CGRectMake(0, 500, self.view.bounds.size.width, 220)];
    [self.view addSubview:selectView];
    [selectView creatView];
    
    selectView.delegate = self;
    
}

-(void)btnClickWithEnum:(MyEnum)myenum {
    self.templateView.templateLayout = self.templateLayouts[myenum];
}


@end
