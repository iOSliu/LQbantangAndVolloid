//
//  LQItemCoordinate.h
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQItemCoordinate : NSObject

@property (assign, nonatomic) NSNumber *x;
@property (assign, nonatomic) NSNumber *y;
@property (assign, nonatomic) NSNumber *w;
@property (assign, nonatomic) NSNumber *h;

+ (instancetype)itemCoordinateMakeWithX:(NSNumber *)x y:(NSNumber *)y w:(NSNumber *)w h:(NSNumber *)h ;

+ (instancetype)itemCoordinateWithDict:(NSDictionary *)dict;

+ (NSArray <__kindof LQItemCoordinate *>*)itemCoordinatesWithArray:(NSArray *)array;

@end
