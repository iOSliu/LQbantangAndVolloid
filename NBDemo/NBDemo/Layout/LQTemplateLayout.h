//
//  LQTemplateLayout.h
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LQItemCoordinate.h"

@interface LQTemplateLayout : NSObject

@property (strong, nonatomic) NSNumber *rowNumber;
@property (strong, nonatomic) NSNumber *arrangeNumber;

@property (strong, nonatomic) NSArray<__kindof LQItemCoordinate *> *itemCoordinaties;

+ (NSArray <__kindof LQTemplateLayout *> *)itemTemplateLayout;

@end
