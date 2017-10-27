//
//  TabBarController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TabBarController.h"
#import "RootNavigationController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)didInitialized{
    [super didInitialized];
    
    _firstTabVc=[[FirstTabViewController alloc] init];
    _firstTabVc.tabBarItem.title=FIRSTTAB_TITLE;
    _firstTabVc.tabBarItem.image=FIRSTTAB_ICON;
    _firstTabVc.tabBarItem.selectedImage = FIRSTTAB_SELECTED_ICON;
    RootNavigationController *rootNavi1 =[[RootNavigationController alloc] initWithRootViewController:_firstTabVc];
    
    _secondTabVc=[[SecondTabViewController alloc] init];
    _secondTabVc.tabBarItem.title=SECONDTAB_TITLE;
    _secondTabVc.tabBarItem.image=SECONDTAB_ICON;
    _secondTabVc.tabBarItem.selectedImage = SECONDTAB_SELECTED_ICON;
    RootNavigationController *rootNavi2 =[[RootNavigationController alloc] initWithRootViewController:_secondTabVc];
    
    _thirdTavVc=[[ThirdTabViewController alloc] init];
    _thirdTavVc.tabBarItem.title=THIRDTAB_TITLE;
    _thirdTavVc.tabBarItem.image=THIRDTAB_ICON;
    _thirdTavVc.tabBarItem.selectedImage = THIRDTAB_SELECTED_ICON;
    RootNavigationController *rootNavi3 =[[RootNavigationController alloc] initWithRootViewController:_thirdTavVc];
    
    _fourthTabVc=[[FourthTabViewController alloc] init];
    _fourthTabVc.tabBarItem.title=FOURTHTAB_TITLE;
    _fourthTabVc.tabBarItem.image=FOURTHTAB_ICON;
    _fourthTabVc.tabBarItem.selectedImage=FOURTHTAB_SELECTED_ICON;
    RootNavigationController *rootNavi4 =[[RootNavigationController alloc] initWithRootViewController:_fourthTabVc];
    
    self.viewControllers=@[rootNavi1,rootNavi2,rootNavi3,rootNavi4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
