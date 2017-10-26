//
//  BaseInterimViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseInterimViewController.h"

@interface BaseInterimViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, weak) UIScrollView *slideView;

@property(nonatomic, weak) UIView *interimView;

@property(nonatomic, strong) UITapGestureRecognizer *tapGestreRecognizer;

@end

@implementation BaseInterimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubviews {
    [super initSubviews];
    /*--------------------------------过渡视图----------------------------------*/
    UIScrollView *slideView = [[UIScrollView alloc] init];
    [self.view addSubview:slideView];
    self.slideView = slideView;
    
    UITapGestureRecognizer *tapGestreRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInterimViewWithEvent:)];
    tapGestreRecognizer.delegate = self;
    _tapGestreRecognizer = tapGestreRecognizer;
    UIView *interimView = [[UIView alloc] init];
    [interimView addGestureRecognizer:tapGestreRecognizer];
    [self.slideView addSubview:interimView];
    self.interimView = interimView;
    
    _tapInterimViewSubject = [RACSubject subject];
}
- (void)tapInterimViewWithEvent:(id)sender{
    [self.tapInterimViewSubject sendNext:sender];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    /*--------------------------------过渡视图----------------------------------*/
    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.interimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.slideView).insets(UIEdgeInsetsZero);
        make.width.equalTo(self.slideView);
    }];
    /// 在布局子控件是参照过渡视图interimView来布局 并且最后还有布局interimView的高度，或者底部约束
       
}
#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}
- (void)dealloc
{
    [self.interimView removeGestureRecognizer:self.tapGestreRecognizer];
    self.tapGestreRecognizer = nil;
    [self.tapInterimViewSubject sendCompleted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
