//
//  ZXXScrollViewPage.h
//  scrollView
//
//  Created by zoekebi_Mac on 2017/2/27.
//  Copyright © 2017年 zoekebi_Mac. All rights reserved.
//  轮播图

#import <UIKit/UIKit.h>

@interface ZXXScrollViewPage :UIView
@property (strong, nonatomic) NSArray *images;
@property (weak, nonatomic, readonly) UIPageControl *pageControl;
/// 父类的dealoc调用改方法来清理资源
- (void)stopTimer;
@property(nonatomic, strong) RACSubject *delegateSubject;
@end
