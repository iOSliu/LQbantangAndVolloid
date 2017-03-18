//
//  UIViewController+KeyboardCorver.m
//  HXClient
//
//  Created by nacker on 16/3/24.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define APPWINDOWHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define APPWINDOWWIDTH  ([UIScreen mainScreen].bounds.size.width)

@interface UIViewController (KeyboardCorver)

@property (strong, nonatomic) UITapGestureRecognizer * keyboardHideTapGesture;
@property (strong, nonatomic) UIView * objectView;

- (void)addNotification;

- (void)clearNotificationAndGesture;
-(void)tapGestureHandel;

@end
