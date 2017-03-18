//
//  LQSelectView.h
//  NBDemo
//
//  Created by 刘强强 on 2017/3/8.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyEnum) {
    MyEnumValueA,
    MyEnumValueB,
    MyEnumValueC,
};

@protocol LQSelectViewDelegate <NSObject>

-(void)btnClickWithEnum:(MyEnum)myenum;

@end

@interface LQSelectView : UIView<UIScrollViewDelegate>

@property(nonatomic, assign) id delegate;

-(void)creatView;

@end
