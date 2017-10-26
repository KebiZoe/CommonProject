//
//  QMUINavigationButton+Block.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "QMUINavigationButton+Block.h"

@interface QMUICommonViewController (Block)

- (void)handleAction:(UIBarButtonItem *)sender;

@end

@implementation QMUICommonViewController (Block)

- (void)handleAction:(UIBarButtonItem *)sender
{
    __block BOOL seek = NO;
    [self.barBtnItemhandlersM enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj[@"item"]==sender) {
            void (^block)(id) = obj[@"handler"];
            block(sender);
            seek = YES;
            *stop = YES;
        }
    }];
    if (seek == NO&&self.barBtnItemhandlersM.count>0) {
        void (^block)(id) = self.barBtnItemhandlersM.firstObject[@"handler"];
        block(sender);
    }
}

@end

@implementation QMUINavigationButton (Block)
+ (UIBarButtonItem *)backBarButtonItemWithTintColor:(UIColor *)tintColor target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self backBarButtonItemWithTarget:target action:@selector(handleAction:) tintColor:tintColor];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)backBarButtonItemWithTarget:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self backBarButtonItemWithTarget:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)closeBarButtonItemWithTintColor:(UIColor *)tintColor target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self closeBarButtonItemWithTarget:target action:@selector(handleAction:) tintColor:tintColor];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)closeBarButtonItemWithTarget:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self closeBarButtonItemWithTarget:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithType:type title:title tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithType:type title:title position:position target:target action:@selector(handleAction:)];
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithNavigationButton:button tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithNavigationButton:button position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithImage:image tintColor:tintColor position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image position:(QMUINavigationButtonPosition)position target:(QMUICommonViewController *)target handler:(void (^)(id))handler{
    UIBarButtonItem *barButtonItem = [self barButtonItemWithImage:image position:position target:target action:@selector(handleAction:)];
    
    if (!barButtonItem) return nil;
    if (target.barBtnItemhandlersM==nil) {
        target.barBtnItemhandlersM = [NSMutableArray array];
    }
    [target.barBtnItemhandlersM addObject:@{@"item":barButtonItem,@"handler":handler}];
    return barButtonItem;
}
@end
