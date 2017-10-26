//
//  ToolBarView.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/8/22.
//  Copyright © 2017年 james. All rights reserved.
//  文章工具栏

#import <UIKit/UIKit.h>

@interface ToolBarView : UIView
@property(nonatomic, weak) QMUIButton *collectButton;
@property(nonatomic, strong) RACSubject *subject;
- (instancetype)initWithTitles:(NSArray *)titles;
@end
