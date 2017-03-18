//
//  LQImgCell.h
//  NBDemo
//
//  Created by 刘强强 on 2017/3/12.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KWidth [UIApplication sharedApplication].keyWindow.bounds.size.width
#define KHeight [UIApplication sharedApplication].keyWindow.bounds.size.height


@protocol LQImgCellDelegate <NSObject>

-(void)imgCellDeleteToIndexPathRow:(NSIndexPath *)indexPath;

@end

@interface LQImgCell : UITableViewCell

@property(nonatomic, strong) UIImage *img;

+(instancetype)imgCellWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@property(nonatomic, assign) id<LQImgCellDelegate> delegate;

@end
