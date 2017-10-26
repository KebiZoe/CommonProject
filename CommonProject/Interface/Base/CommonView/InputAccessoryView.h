//
//  InputAccessoryView.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,InputAccessoryViewType){
    InputAccessoryViewTypeNormal = 1,
    InputAccessoryViewTypeAccomplish = 2
};
@interface InputAccessoryView : UIView

/**
 完成按钮
 */
@property(nonatomic, weak) UIButton *accompishBtn;
/**
 取消按钮
 */
@property(nonatomic, weak) UIButton *cancelBtn;

- (instancetype)initWithHeight:(CGFloat)height inputAccessoryViewType:(InputAccessoryViewType)type;

@end
