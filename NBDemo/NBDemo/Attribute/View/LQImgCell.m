//
//  LQImgCell.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/12.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQImgCell.h"

@interface LQImgCell ()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UIButton *editBtn;

@property(nonatomic, strong) UITextField *textFiled;

@property(nonatomic, strong) UIButton *deleteBtn;

@property(nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *cellID = @"imgCell";

@implementation LQImgCell

+(instancetype)imgCellWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    LQImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LQImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setupSubview];
    }
    cell.indexPath = indexPath;
    return cell;
}

-(void)setupSubview {
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_bgView];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.userInteractionEnabled = YES;
    [_bgView addSubview:_imgView];
    
    _editBtn = [[UIButton alloc] init];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editeClick) forControlEvents:UIControlEventTouchUpInside];
    [_imgView addSubview:_editBtn];
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.font = [UIFont systemFontOfSize:12];
    _textFiled.placeholder = @"描述..";
    _textFiled.hidden = YES;
    _textFiled.textColor = [UIColor lightGrayColor];
    [_bgView addSubview:_textFiled];
    
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteClcik) forControlEvents:UIControlEventTouchUpInside];
    [_imgView addSubview:_deleteBtn];
}

-(void)deleteClcik {
    if ([_delegate respondsToSelector:@selector(imgCellDeleteToIndexPathRow:)]) {
        [_delegate imgCellDeleteToIndexPathRow:_indexPath];
    }
}

-(void)editeClick {
    _textFiled.hidden = NO;
}

-(void)setImg:(UIImage *)img {
    _img = img;
    
    CGSize size = _img.size;
    CGFloat width = size.width;
    
    CGFloat height = size.height;
    if (size.width >= KWidth) {
        width = KWidth;
    }
    
    if (size.height >= KHeight) {
        height = KHeight;
    }
    
    _bgView.frame = CGRectMake(0, 0, KWidth, height + 20);
    
    _imgView.frame = CGRectMake(0, 0, KWidth, height);
    _imgView.image = img;
    
    _editBtn.frame = CGRectMake(0, height - 30, 80, 30);
    
    _textFiled.frame = CGRectMake(0, height, KWidth, 20);
    
    _deleteBtn.frame = CGRectMake(KWidth - 35, 0, 35, 35);
}

-(void)setDelegate:(id<LQImgCellDelegate>)delegate {
    _delegate = delegate;
}

@end
