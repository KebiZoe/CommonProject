//
//  ZXXScrollViewPage.m
//  scrollView
//
//  Created by zoekebi_Mac on 2017/2/27.
//  Copyright © 2017年 zoekebi_Mac. All rights reserved.
//

#import "ZXXScrollViewPage.h"
static int const ImageViewCount = 3;

@interface ZXXScrollViewPage() <UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) NSTimer *timer;
@property(nonatomic, weak) NSArray *imageVs;
@property(nonatomic, strong) NSArray *gestures;
@end
@implementation ZXXScrollViewPage
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 图片控件
        NSMutableArray *arrM = [NSMutableArray array];
        NSMutableArray *arr2M = [NSMutableArray array];
        for (int i = 0; i<ImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewWithUITapGestureRecognizer:)];
            [imageView addGestureRecognizer:tapGg];
            [scrollView addSubview:imageView];
            [arrM addObject:imageView];
            [arr2M addObject:tapGg];
        }
        self.imageVs = arrM;
        self.gestures = arr2M;
        
        // 页码视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
        _delegateSubject = [RACSubject subject];
    }
    return self;
}

- (void)tapImageViewWithUITapGestureRecognizer:(id)sender{
    [self.delegateSubject sendNext:@(self.pageControl.currentPage)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-3);
    }];
}
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 设置页码
    self.pageControl.numberOfPages = images.count;
    
    self.pageControl.currentPage = 0;
    // 设置内容
    [self initWithFirstPage];
}

- (void)initWithFirstPage{
    // 设置图片
    NSInteger index = 0;
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        index = self.pageControl.currentPage;
        if (i == 1) {
            index++;
        } else if (i == 2) {
            index = index + 2
            ;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
//        imageView.image = self.images[index];
        if (self.images.count>0) {
            [imageView setImageWithURL:[NSURL URLWithString:self.images[index]] placeholder:[UIImage imageNamed:[NSString stringWithFormat:@"banner%zd",(index%2)+1]]];
        }else{
            [imageView setImageWithURL:nil placeholder:[UIImage imageNamed:@"banner1"]];
        }
    }
    
    // 设置偏移量在中间
    
    [self scrollViewDidScroll:self.scrollView];
    // 开始定时器
    [self startTimer];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        
        
        distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
    
}

#pragma mark - 内容更新
- (void)updateContent
{
    // 设置图片
    NSInteger index = 0;
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        index = self.pageControl.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
//        imageView.image = self.images[index];
        if (self.images.count>0) {
            
            [imageView setImageWithURL:[NSURL URLWithString:self.images[index]] placeholder:[UIImage imageNamed:[NSString stringWithFormat:@"banner%zd",(index%2)+1]]];
        }else{
            [imageView setImageWithURL:nil placeholder:[UIImage imageNamed:@"banner1"]];
        }
    }
    
    // 设置偏移量在中间
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self scrollViewDidScroll:self.scrollView];
    
}
#pragma mark - 定时器处理
- (void)startTimer
{
    if(self.timer){
        [self stopTimer];
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc
{
    [self.imageVs enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeGestureRecognizer:self.gestures[idx]];
    }];
    self.gestures = nil;
}
- (void)next
{
    if(self.scrollView.contentOffset.x == 0){
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}

@end
