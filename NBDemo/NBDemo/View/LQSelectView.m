//
//  LQSelectView.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/8.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQSelectView.h"

@interface LQSelectView ()
{
    int number;
}

@property(nonatomic, strong) UIScrollView * scrollView;

@property(nonatomic, strong) NSMutableArray *btnArr;

@end

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"jpg"]]

@implementation LQSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)creatView {
    number = 10;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH/3 * number, 100);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    [self addSubview:self.scrollView];
    
    NSMutableArray * imageNameArr = [[NSMutableArray alloc]initWithObjects:@"66",@"australia",@"beach",@"building",@"hands",@"indonesia",@"montain",@"nyc",@"seattle",@"66", nil];
    
    for (int i = 0; i < number; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 10010+i;
        float offsizeX = fabs(SCREEN_WIDTH/6 * (2 * i + 1)- SCREEN_WIDTH/2 - self.scrollView.contentOffset.x);
        double offsizeY = sqrt(fabs(SCREEN_WIDTH * SCREEN_WIDTH / 4 - offsizeX * offsizeX));
        
        button.center = CGPointMake(SCREEN_WIDTH/6 * (2 * i + 1),SCREEN_WIDTH/2 - offsizeY + SCREEN_WIDTH/4);
        button.bounds = CGRectMake(0, 0,  (SCREEN_WIDTH/2-offsizeX)/(SCREEN_WIDTH/2)*40+20, (SCREEN_WIDTH/2-offsizeX)/(SCREEN_WIDTH/2)*40+20);
        
        [button setBackgroundImage:LOADIMAGE(imageNameArr[i]) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];

        [self.btnArr addObject:button];
        
        if (i==0 || i == number) {
            button.enabled = NO;
        }
    }
    
}
//button点击事件
-(void)btnClick:(UIButton *)btn {
    
    [_delegate btnClickWithEnum:(btn.tag-10010-1)];
    
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH/3 * (btn.tag-10010-1), 0) animated:YES];
}

-(void)setDelegate:(id)delegate {
    _delegate = delegate;
}

//scrollerView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    int location = 0;
//    
//    location = scrollView.contentOffset.x/(SCREEN_WIDTH/3);
    
    for (int i = 0; i < number; i ++)
    {
        UIButton * btn = self.btnArr[i];
        
        float offsizeX = fabs(btn.center.x- SCREEN_WIDTH/2 - scrollView.contentOffset.x);
        double offsizeY = sqrt(fabs(SCREEN_WIDTH * SCREEN_WIDTH / 4 - offsizeX * offsizeX));
        
        btn.center = CGPointMake(btn.center.x,SCREEN_WIDTH/2- offsizeY + SCREEN_WIDTH/4);
        btn.bounds = CGRectMake(0, 0,  (SCREEN_WIDTH/2-offsizeX)/(SCREEN_WIDTH/2)*40+20, (SCREEN_WIDTH/2-offsizeX)/(SCREEN_WIDTH/2)*40+20);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int location = 0;
    
    CGFloat yy = scrollView.contentOffset.x/(SCREEN_WIDTH/3);
    
    int xx  = yy*10;
    if (xx%10 >= 5) {
        location = xx/10 +1;
    }else {
        location = xx/10;
    }
    
    [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH/3 * location, 0) animated:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    int location = 0;
    
    CGFloat yy = scrollView.contentOffset.x/(SCREEN_WIDTH/3);
    
    int xx  = yy*10;
    if (xx%10 >= 5)
    {
        location = xx/10 +1;
    }else
    {
        location = xx/10;
    }
    
    [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH/3 * location, 0) animated:YES];
}

-(NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
        
    }
    return _btnArr;
}







@end
