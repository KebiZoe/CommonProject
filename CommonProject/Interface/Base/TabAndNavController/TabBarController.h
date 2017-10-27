//
//  TabBarController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabViewController.h"
#import "SecondTabViewController.h"
#import "ThirdTabViewController.h"
#import "FourthTabViewController.h"
@interface TabBarController : QMUITabBarViewController

@property(nonatomic, strong) FirstTabViewController *firstTabVc;
@property(nonatomic, strong) SecondTabViewController *secondTabVc;
@property(nonatomic, strong) ThirdTabViewController *thirdTavVc;
@property(nonatomic, strong) FourthTabViewController *fourthTabVc;

@end
