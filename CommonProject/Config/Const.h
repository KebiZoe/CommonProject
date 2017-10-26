//
//  Const(常量文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Const_______h
#define Const_______h

/**errorcode*/
static NSString* const NETWORK_ERROR = @"10000";

/**api请求地址*/
static NSString* const BASE_URL=@"http://medical.moovi-tech.com";

/**友盟appkey*/
static NSString* const USHARE_APPKEY=@"58dc9efa82b6355dc4000eb0";

/**极光参数*/
static NSString* const JPUSH_APPKEY=@"4b3e601ca50b9e2207f76f62";
static NSString* const JPUSH_CHANNEL=@"APP Store";


#pragma mark - reuseIdentifier - 重用标识
/**cell重用标识*/
// BaseSetingViewCell
static NSString* const CELLCOMMON = @"CELLCOMMON_IDENTIFIER";
static NSString* const CELLCOMMON_EDIT = @"CELLCOMMON_EDIT_IDENTIFIER";
// BonusTableViewCell
static NSString* const BonusTableViewCellID = @"BonusTableViewCellID";
// ArticleTableViewCell
static NSString* const ArticleTableViewCellID = @"ArticleTableViewCellID";
// MyMessageViewCellId
static NSString* const MyMessageViewCellId = @"MyMessageViewCellId";
// TopicTableViewCellID
static NSString* const TopicTableViewCellID = @"TopicTableViewCellID";


#pragma mark - User_default Keys
/** 远程推送@(BOOL) */
static NSString* const isRegisterForRemoteNotifications = @"isRegisterForRemoteNotifications";
/** 用户信息NSDictionary */
static NSString* const userInfo = @"userInfo";
static NSString* const mobile = @"mobile";
static NSString* const token = @"token";
static NSString* const BugoutConfigEnabledShakeFeedback = @"BugoutConfigEnabledShakeFeedback";
static NSString* const defaultAddress = @"defaultAddress";

#pragma mark - FONT_name_size
/**COMMON_NAME*/
static NSString* const FONT_NAME = @"PingFangSC-Regular";
/**COMMON_SIZE*/
static CGFloat const FONT_SIZE = 16;

#endif /* Const_______h */
