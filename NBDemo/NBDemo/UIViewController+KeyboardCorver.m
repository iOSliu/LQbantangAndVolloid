//
//  UIViewController+KeyboardCorver.m
//  HXClient
//
//  Created by nacker on 16/3/24.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import "UIViewController+KeyboardCorver.h"

static void * keyboardHideTapGestureKey = (void *)@"keyboardHideTapGesture";
static void * objectViewKey = (void *)@"objectView";


@implementation UIViewController (KeyboardCorver)

@dynamic keyboardHideTapGesture;
@dynamic objectView;

- (void)setKeyboardHideTapGesture:(UITapGestureRecognizer *)keyboardHideTapGesture{
    objc_setAssociatedObject(self, keyboardHideTapGestureKey, keyboardHideTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)keyboardHideTapGesture{
    return objc_getAssociatedObject(self, keyboardHideTapGestureKey);
}

- (void)setObjectView:(UIView *)objectView{
    objc_setAssociatedObject(self, objectViewKey, objectView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)objectView{
    return objc_getAssociatedObject(self, objectViewKey);
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setKeyboardHideTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandel)]];
//    [self.view addGestureRecognizer:self.keyboardHideTapGesture];
}

- (void)clearNotificationAndGesture{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view removeGestureRecognizer:self.keyboardHideTapGesture];
}

- (void)tapGestureHandel{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)findFirstResponse:(UIView *)view{
    UIView * ojView = self.objectView;
    ojView = nil;
    for (UIView * tempView in view.subviews) {
        if ([tempView isFirstResponder] &&
            ([tempView isKindOfClass:[UITextField class]] ||
             [tempView isKindOfClass:[UITextView class]])) {//要进行类型判断
                [self setObjectView:tempView];
            }
        if (tempView.subviews.count != 0) {
            [self findFirstResponse:tempView];
        }
    }
}

- (void)keyboardNotify:(NSNotification *)notify{

    NSValue * frameNum = [notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = frameNum.CGRectValue;
    CGFloat keyboardHeight = rect.size.height;//键盘高度
    
    CGFloat duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];//获取键盘动画持续时间
    NSInteger curve = [[notify.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];//获取动画曲线
    
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {//键盘显示
        [self.view addGestureRecognizer:self.keyboardHideTapGesture];
        [self findFirstResponse:self.view];
        UIView * tempView = self.objectView;
        CGPoint point = [tempView convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];//计算响应者到和屏幕的绝对位置
        CGFloat keyboardY = APPWINDOWHEIGHT - keyboardHeight;
        CGFloat tempHeight = point.y + tempView.frame.size.height;
        if (tempHeight > keyboardY) {
            CGFloat offsetY;
            if (APPWINDOWHEIGHT-tempHeight < 0) {//判断是否超出了屏幕,超出屏幕做偏移纠正
                offsetY = keyboardY - tempHeight + (tempHeight-APPWINDOWHEIGHT);
            }else{
                offsetY = keyboardY - tempHeight;
            }
            if (duration > 0) {
                [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                    //2016年11月28日16:13:33解决输入时切换输入法语言出现的遮挡输入框问题
                    self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, offsetY);//CGAffineTransformMakeTranslation(0, offsetY);
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                //2016年11月28日16:13:33解决输入时切换输入法语言出现的遮挡输入框问题
                self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, offsetY);//CGAffineTransformMakeTranslation(0, offsetY);
            }
            
        }
        
    }else if ([notify.name isEqualToString:UIKeyboardWillHideNotification]){//键盘隐藏
        [self.view removeGestureRecognizer:self.keyboardHideTapGesture];
        if (duration > 0) {
            [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                self.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
}


@end
