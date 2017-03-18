//
//  LQTemplateView.h
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQTemplateLayout;

@interface LQTemplateView : UIView

///defalut 3
@property (assign, nonatomic, readonly) NSUInteger rowNumber;

///defalut 3
@property (assign, nonatomic, readonly) NSUInteger arrangeNumber;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@property (strong, nonatomic) LQTemplateLayout *templateLayout;

@end
