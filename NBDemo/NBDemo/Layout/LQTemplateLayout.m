//
//  LQTemplateLayout.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQTemplateLayout.h"

@implementation LQTemplateLayout

+ (NSArray <__kindof LQTemplateLayout *> *)itemTemplateLayout {
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *layouts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"layout" ofType:@"plist"]];
    for (NSDictionary *layout in layouts) {
        LQTemplateLayout *template = [[LQTemplateLayout alloc]init];
        template.itemCoordinaties = [LQItemCoordinate itemCoordinatesWithArray:layout[@"itemCoordinaties"]];
        template.rowNumber = layout[@"rowNumber"];
        template.arrangeNumber = layout[@"arrangeNumber"];
        [array addObject:template];
    }
    return array;
}

@end
