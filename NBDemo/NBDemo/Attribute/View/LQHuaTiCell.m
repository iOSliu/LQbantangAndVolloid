//
//  LQHuaTiCell.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQHuaTiCell.h"
#import "UIView+Extension.h"

@interface LQHuaTiCell ()

@property(nonatomic, strong) UITextField *textView;



@end

static NSString *cellID = @"huatiCell";

@implementation LQHuaTiCell

+(instancetype)huaTiCellWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    LQHuaTiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LQHuaTiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setupSubview];
    }
    return cell;
}

-(void)setupSubview {
    self.textView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
//    self.textView.backgroundColor = [UIColor lightGrayColor];
    self.textView.placeholder = @"标题";
    self.textView.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.textView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 365, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
}
@end
