//
//  LQItemCoordinate.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQItemCoordinate.h"

@implementation LQItemCoordinate

+ (instancetype)itemCoordinateMakeWithX:(NSNumber *)x y:(NSNumber *)y w:(NSNumber *)w h:(NSNumber *)h {
    LQItemCoordinate *item = [[LQItemCoordinate alloc] init];
    item.x = x;
    item.x = y;
    item.x = w;
    item.x = h;
    return item;
}

+ (instancetype)itemCoordinateWithDict:(NSDictionary *)dict {
    LQItemCoordinate *item = [[LQItemCoordinate alloc] init];
    item.x = dict[@"x"];
    item.y = dict[@"y"];
    item.w = dict[@"w"];
    item.h = dict[@"h"];
    return item;
}

+ (NSArray <__kindof LQItemCoordinate *>*)itemCoordinatesWithArray:(NSArray *)array {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arr addObject:[LQItemCoordinate itemCoordinateWithDict:dict]];
    }
    
    return arr;
}

@end
