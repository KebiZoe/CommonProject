//
//  BaseInterimViewController.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/24.
//  Copyright © 2017年 james. All rights reserved.
//  底部scrollView + 过渡视图

#import "BaseViewController.h"

@interface BaseInterimViewController : BaseViewController
///底层的滑动视图
@property(nonatomic, weak ,readonly) UIScrollView *slideView;
/**
 过渡视图
 */
@property(nonatomic, weak, readonly) UIView *interimView;

@property(nonatomic, strong) RACSubject *tapInterimViewSubject;
@end
