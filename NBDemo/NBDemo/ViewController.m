//
//  ViewController.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/8.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "ViewController.h"

#import "LQTemplateViewController.h"
#import "LQAttriViewController.h"

#import "LQTestViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *mArr;

@end

static NSString *KCellID = @"cellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"入口";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellID];
    }
    
    cell.textLabel.text = self.mArr[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LQAttriViewController *attriVC = [[LQAttriViewController alloc] init];
        [self.navigationController pushViewController:attriVC animated:YES];
    }else if(indexPath.row == 1){
        
        LQTemplateViewController *temVC = [[LQTemplateViewController alloc] init];
        
        [self.navigationController pushViewController:temVC animated:YES];
        
    }else {
        LQTestViewController *testView = [[LQTestViewController alloc] init];
        [self.navigationController pushViewController:testView animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


-(NSMutableArray *)mArr {
    if (!_mArr) {
        _mArr = [NSMutableArray array];
        [_mArr addObject:@"富文本"];
        [_mArr addObject:@"搭配"];
        [_mArr addObject:@"测试"];
    }
    return _mArr;
}


@end
