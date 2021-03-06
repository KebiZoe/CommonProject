//
//  ZXXAttributeItem.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXXAttributeItem : NSObject
/**
 *  imageEdgeInsets，这个属性用来调整imageView里面图片的位置，有些情况titleLabel前面是一个icon，但是icon与titleLabel的间距不是你想要的。<br/>
 *  @warning 目前只对UITableViewCellStyleDefault和UITableViewCellStyleSubtitle类型的cell开放
 */
@property(nonatomic, assign) UIEdgeInsets imageEdgeInsets;

/**
 *  textLabelEdgeInsets，这个属性和imageEdgeInsets合作使用，用来调整titleLabel的位置，默认为 UIEdgeInsetsZero。<br/>
 *  @warning 目前只对UITableViewCellStyleDefault和UITableViewCellStyleSubtitle类型的cell开放。
 */
@property(nonatomic, assign) UIEdgeInsets textLabelEdgeInsets;

/// 与textLabelEdgeInsets一致，作用目标为detailTextLabel，默认为 UIEdgeInsetsZero。
@property(nonatomic, assign) UIEdgeInsets detailTextLabelEdgeInsets;

/// 用于调整右边 accessoryView 的布局偏移，默认为 UIEdgeInsetsZero。
@property(nonatomic, assign) UIEdgeInsets accessoryEdgeInsets;
/**
 当使用这个时会替换掉模型里面的UIImage对象 字典为@{@"imageUrl":@"www.baidu.com/Pic.png",@"placeHolder":@"imageName"}
 */
@property(nonatomic, copy,nullable) NSDictionary *imageDict;
/**
 对image圆形裁剪
 */
@property(nonatomic, assign) BOOL circular_clips;

/**
 主标题的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *titleFont;

/**
 主标题的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *titleColor;

/**
 副标题的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *subTitleFont;

/**
 副标题的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *subTitleColor;

/**
 右边的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *rightTitleFont;

/**
 右边的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *rightTitleColor;

/**
 右边不图片大小
 */
@property(nonatomic, assign) CGSize rightImageSize;

/**
 当使用这个时会替换掉模型里面的rightImage对象 字典为@{@"imageUrl":@"www.baidu.com/Pic.png",@"placeHolder":@"imageName"}
 */
@property(nonatomic, copy,nullable) NSDictionary *rightImageDict;

/**
 占位文字
 */
@property (nonatomic,copy,nullable)NSString *rightPlaceHolder;
/**
 右边的textField禁止编辑 YES为禁止
 */
@property(nonatomic, assign) BOOL rightTextField_forbidEdit;

@end
