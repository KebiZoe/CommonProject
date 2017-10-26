//
//  ImageEditViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ImageEditViewController.h"
#import "ZXXImageCropManager.h"

@interface ImageEditViewController ()<UIScrollViewDelegate>

@property(nonatomic, weak)UIScrollView *scrll;

@property (weak,nonatomic)UIImageView *imgview;

@property(nonatomic, weak)UIView *subview;

@end

@implementation ImageEditViewController{
    CGSize _imgSize;
}

- (void)didInitialized {
    [super didInitialized];
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    @WeakObj(self);
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"完成" position:QMUINavigationButtonPositionNone target:self handler:^(id sender) {
        @StrongObj(self);
        // 裁剪区域
        CGRect rect = CGRectMake((self.subview.bounds.size.width-self.size.width)/2, (self.subview.bounds.size.height-self.size.height)/2, self.size.width, self.size.height);
        UIImage *image = [ZXXImageCropManager cropImageView:self.imgview toRect:rect zoomScale:1 containerView:self.subview shouldFixOrientation:YES];
        self.block(image);
        [self pop];
    }];
}
- (void)initSubviews {
    [super initSubviews];
    self.view.backgroundColor = UIColorBlack;
    
    UIScrollView *scrll = [[UIScrollView alloc]init];
    [self.view addSubview:scrll];
    self.scrll = scrll;
    scrll.maximumZoomScale = 5;
    scrll.minimumZoomScale = 0.2;
    scrll.delegate = self;
    scrll.showsHorizontalScrollIndicator = NO;
    scrll.showsVerticalScrollIndicator = NO;
    
    UIImageView *imgview = [[UIImageView alloc] init];
    [scrll addSubview:imgview];
    self.imgview = imgview;
    UIImage *image = self.receivedData[@"image"];
    self.imgview.image = image;
    
    UIView *subview = [[UIView alloc] init];
    subview.userInteractionEnabled = NO;
    [self.view addSubview:subview];
    self.subview = subview;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIImage *image = self.receivedData[@"image"];
    CGSize size = image.size;
    
    CGFloat wirth = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    CGFloat imgWirth = self.size.width<wirth?self.size.width:wirth;
    CGFloat imgHeight = imgWirth*size.height/size.width;
    if (imgHeight>height) {
        imgHeight = height;
        imgWirth = imgHeight*size.width/size.height;
    }
    
    /// 裁剪的size
    CGSize clipsize = self.size;
    self.size = CGSizeMake(imgWirth, clipsize.height*imgWirth/clipsize.width<height?clipsize.height*imgWirth/clipsize.width:height);
    
    self.scrll.frame = CGRectMake(0, 0, wirth, height);
    self.scrll.contentSize = CGSizeMake(wirth, height);
    if (imgHeight>self.size.height) {
        self.scrll.contentInset = UIEdgeInsetsMake((imgHeight-self.size.height)/2, 0, (imgHeight-self.size.height)/2, 0);
    }else{
        self.scrll.contentInset = UIEdgeInsetsZero;
    }
    _imgSize = CGSizeMake(imgWirth, imgHeight);
    self.imgview.bounds = CGRectMake(0, 0, imgWirth, imgHeight);
    self.imgview.center = CGPointMake(wirth/2, height/2);
    
    self.subview.frame = CGRectMake(0, 0, wirth, height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.block = self.receivedData[@"block"];
    
    self.size = [self.receivedData[@"size"] CGSizeValue];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrll.contentOffset = CGPointZero;
    
    if (!CGSizeIsEmpty(self.size)) {
        CGFloat wirth = self.size.width;
        CGFloat height = self.size.height;
        
        [ZXXImageCropManager overlayClippingWithView:self.subview cropRect:CGRectMake((self.subview.bounds.size.width-wirth)/2, (self.subview.bounds.size.height-height)/2, wirth, height) containerView:self.subview needCircleCrop:NO];
    }
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    _imgview.center = CGPointMake(scrollView.contentSize.width/2+offsetX,scrollView.contentSize.height/2+offsetY);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    
    if (scale<1) {
        if (_imgSize.height>self.size.height) {
            self.scrll.contentInset = UIEdgeInsetsMake((_imgSize.height-self.size.height)/2, (_imgSize.width-self.size.width)/2, (_imgSize.height-self.size.height)/2, (_imgSize.width-self.size.width)/2);
        }else{
            self.scrll.contentInset = UIEdgeInsetsMake(0, (_imgSize.width-self.size.width)/2, 0, (_imgSize.width-self.size.width)/2);
        }
        [scrollView setContentOffset:CGPointZero animated:NO];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            view.center = CGPointMake(scrollView.frame.size.width/2, scrollView.frame.size.height/2);
            view.transform = CGAffineTransformIdentity;
        }];
    }else{
        if (scrollView.contentSize.height>self.size.height) {
            self.scrll.contentInset = UIEdgeInsetsMake((scrollView.frame.size.height-self.size.height)/2, (scrollView.frame.size.width-self.size.width)/2, (scrollView.frame.size.height-self.size.height)/2, (scrollView.frame.size.width-self.size.width)/2);
            view.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height/2);
            if (scrollView.contentSize.height<scrollView.frame.size.height) {
                [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,-(scrollView.frame.size.height-scrollView.contentSize.height)/2) animated:NO];
            }
        }else{
            self.scrll.contentInset = UIEdgeInsetsMake(0, (scrollView.frame.size.width-self.size.width)/2, 0, (scrollView.frame.size.width-self.size.width)/2);
            view.center = CGPointMake(scrollView.contentSize.width/2, scrollView.frame.size.height/2);
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgview;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.receivedData = nil;
}

@end
