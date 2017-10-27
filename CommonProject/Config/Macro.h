//
//  Macro(宏文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import "RACEXTScopeZxx.h"
#ifndef Macro______h
#define Macro______h



///*weak和strong*/
//#define WeakObj(o) __weak typeof(o) o##Weak = o;
//#define StrongObj(o) __strong typeof(o) o = o##Weak;


#pragma mark - 高度和宽度
///这个QMUI宏定义已经做好了


#pragma mark - 欢迎页图片
/**欢迎页图片*/
#define WELCOME_IMAGECOUNT 3
#define WELCOME_IMAGE(index) [NSString stringWithFormat:@"welcome_image%d",index]


#pragma mark - tabbar图标和文字
/**tabbar图标和文字*/
#define FIRSTTAB_TITLE @"tab1"
#define SECONDTAB_TITLE @"tab2"
#define THIRDTAB_TITLE @"tab3"
#define FOURTHTAB_TITLE @"tab4"

#define FIRSTTAB_ICON [UIImage imageNamed:@"firstTabIcon"]
#define SECONDTAB_ICON [UIImage imageNamed:@"secondTabIcon"]
#define THIRDTAB_ICON [UIImage imageNamed:@"thirdTabIcon"]
#define FOURTHTAB_ICON [UIImage imageNamed:@"fourthTabIcon"]

#define FIRSTTAB_SELECTED_ICON [UIImage imageNamed:@"firstTabIcon_sel"]
#define SECONDTAB_SELECTED_ICON [UIImage imageNamed:@"secondTabIcon_sel"]
#define THIRDTAB_SELECTED_ICON [UIImage imageNamed:@"thirdTabIcon_sel"]
#define FOURTHTAB_SELECTED_ICON [UIImage imageNamed:@"fourthTabIcon_sel"]

#pragma mark - 颜色
/**16进制颜色转换*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define ClearColor [UIColor clearColor]
#define COLOR_MAIN [UIColor colorWithRed:0.573 green:0.208 blue:0.455 alpha:1.000]
#define COLOR_BACKGROUND [UIColor whiteColor]
#define COLOR_TEXT [UIColor colorWithWhite:0.200 alpha:1.000]

#pragma mark - 带有边框的
/**带有边框的*/
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#pragma mark - NSUserDefaults
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

/**FONT*/
#pragma mark - FONT
#define FONT_COMMON [UIFont fontWithName:FONT_NAME size:FONT_SIZE]
#define FONT(fontsize) [UIFont fontWithName:FONT_NAME size:(fontsize)]

#if TARGET_IPHONE_SIMULATOR//模拟器
#elif TARGET_OS_IPHONE//真机
#endif

#ifdef DEBUG//调试
#define ZXXLog(...) NSLog(__VA_ARGS__)
#else//发布
#define ZXXLog(...)
#endif

#endif /* Macro______h */
