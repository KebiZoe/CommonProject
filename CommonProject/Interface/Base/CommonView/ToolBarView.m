//
//  ToolBarView.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/8/22.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ToolBarView.h"

@implementation ToolBarView{
    NSMutableArray *_arraM;
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
//        NSArray *titles = @[@"评论",@"分享",@"收藏",@"打赏"];
        NSMutableArray *arraM = [NSMutableArray array];
        for (int i=0; i<titles.count; i++) {
            QMUIButton *button = [[QMUIButton alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"toolIcon%zd",i+1]] title:titles[i]];
            button.imagePosition = QMUIButtonImagePositionTop;
            button.spacingBetweenImageAndTitle = 2;
            [button setTitleColor:UIColorFromRGB(0xbfbfbf) forState:UIControlStateNormal];
            button.titleLabel.font = FONT(11);
            [button addTarget:self action:@selector(toolBarButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            if (i==2) {
                self.collectButton = button;
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"toolIcon%zdS",i+1]] forState:UIControlStateSelected];
            }
            [self addSubview:button];
            [arraM addObject:button];
        }
        self.qmui_borderPosition = QMUIBorderViewPositionTop;
        _arraM = arraM;
    }
    
    _subject = [RACSubject subject];
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger cout = _arraM.count;
    CGFloat btnWidth = 40;
    CGFloat width = self.frame.size.width;
    CGFloat margin = (width - btnWidth*cout)/cout;
    @WeakObj(self);
    [_arraM enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @StrongObj(self);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(idx*(margin+btnWidth)+margin/2);
            make.width.offset(40);
            make.height.equalTo(self);
        }];
    }];
}
- (void)toolBarButtonTap:(id)sender{
    if (self.subject) {
        [self.subject sendNext:sender];
    }
}
@end
