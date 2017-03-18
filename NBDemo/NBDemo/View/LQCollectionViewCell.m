//
//  LQCollectionViewCell.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQCollectionViewCell.h"

#import "LQTemplateView.h"

@interface LQCollectionViewCell ()

@property (strong, nonatomic) LQTemplateView *templateView;

@end

@implementation LQCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)createSubviews {
    _templateView = [[LQTemplateView alloc]initWithFrame:CGRectMake(0, 0, 375, 375)];
    [self.contentView addSubview:_templateView];
}

- (void)setTemplateLayout:(LQTemplateLayout *)templateLayout {
    _templateLayout = templateLayout;
    _templateView.templateLayout = templateLayout;
}

@end
