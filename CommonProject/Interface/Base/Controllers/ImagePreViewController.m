//
//  ImagePreViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/8/21.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ImagePreViewController.h"

@interface ImagePreViewController ()
@property(nonatomic, weak) UIImageView *imageView;
@end

@implementation ImagePreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    @WeakObj(self);
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"取消" position:-1 target:self handler:^(id sender) {
        @StrongObj(self);
        void (^imgBlock)(QMUIAsset *) = self.receivedData[@"block"];
        imgBlock(self.receivedData[@"QMUIAsset"]);
        [self pop];
    }];
}
- (void)initSubviews {
    [super initSubviews];
    QMUIAsset *asset = self.receivedData[@"QMUIAsset"];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    self.imageView.image = asset.originImage;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
