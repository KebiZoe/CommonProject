//
//  BaseViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/message.h>
@interface BaseViewController ()
@property (copy,nonatomic,nullable)RequestBlock successBlock;

@property (copy,nonatomic,nullable)RequestBlock failureBlock;

@property (copy,nonatomic,nullable)BatchBlock chainArrayBlock;

@property (copy,nonatomic,nullable)BatchBlock chainFailedArrayBlock;

@property (copy,nonatomic,nullable)RequestBlock chainFailedBlck;
@end
@implementation BaseViewController{
    UIView *_baseView;
}

+ (void)load{
    Method a = class_getInstanceMethod(self, @selector(loadView));
    Method b = class_getInstanceMethod(self, @selector(loadCustomView));
    method_exchangeImplementations(a, b);
}
- (void)loadView{
    [super loadView];
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [[UIView alloc] init];
    }
    return _baseView;
}
- (void)didInitialized {
    [super didInitialized];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
- (void)loadCustomView{
    self.view = self.baseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHandle_UIEvent];
}

- (void)setHandle_UIEvent{
    
}
- (void)initSubviews {
    [super initSubviews];
    self.view.backgroundColor = COLOR_BACKGROUND;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟页面分析
//    [UMAnalytics beginLogViewController:NSStringFromClass(self.class)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟页面分析
//    [UMAnalytics endLogViewController:NSStringFromClass(self.class)];
}

#pragma mark —— push下一个页面
/*不传数据，直接push到下一个界面*/
-(void)push:(NSString*)controllerName{
    QMUINavigationController *navVc = (QMUINavigationController *)self.navigationController;
    if (!navVc.isViewControllerTransiting) {
        Class class=NSClassFromString(controllerName);
        id controller=[[class alloc] init];
        [self.navigationController pushViewController:controller animated:true];
    }
}

/*传数据到下一个界面*/
-(void)push:(NSString*)controllerName Data:(id)data{
    QMUINavigationController *navVc = (QMUINavigationController *)self.navigationController;
    if (!navVc.isViewControllerTransiting) {
        Class class=NSClassFromString(controllerName);
        id controller=[[class alloc] init];
        ((BaseViewController*)controller).receivedData=data;
        [self.navigationController pushViewController:controller animated:true];
    }
}

#pragma mark —— 返回事件
/*关闭界面，返回上一级*/
-(void)pop{
    if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*返回到固定界面*/
-(void)popToController:(NSString*)controllerName{
    Class class=NSClassFromString(controllerName);
    id controller=[[class alloc] init];
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[controller class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
}

/*返回到主界面*/
-(void)popToRoot{
    [self.navigationController popToRootViewControllerAnimated:true];
}
@end
