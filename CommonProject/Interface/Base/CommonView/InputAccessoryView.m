//
//  InputAccessoryView.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "InputAccessoryView.h"

@implementation InputAccessoryView{
    InputAccessoryViewType _type;
}


- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
    
    [path moveToPoint:CGPointMake(0, rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    
    [[UIColor colorWithWhite:0.894 alpha:1.000] set];
    [path stroke];
}
- (instancetype)initWithHeight:(CGFloat)height inputAccessoryViewType:(InputAccessoryViewType)type{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        _type = type;
        if (type == InputAccessoryViewTypeNormal) {
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:cancelBtn];
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.cancelBtn = cancelBtn;
            
            UIButton *accomplish = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:accomplish];
            [accomplish setTitle:@"完成" forState:UIControlStateNormal];
            [accomplish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.accompishBtn = accomplish;
        }else if(type == InputAccessoryViewTypeAccomplish){
            UIButton *accomplish = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:accomplish];
            [accomplish setTitle:@"完成" forState:UIControlStateNormal];
            [accomplish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.accompishBtn = accomplish;
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_type == InputAccessoryViewTypeNormal) {
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
            make.width.offset(60);
        }];
        [self.accompishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
            make.width.offset(60);
        }];
    }else if(_type == InputAccessoryViewTypeAccomplish){
        [self.accompishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
            make.width.offset(60);
        }];
    }
}

- (void)dealloc
{
    NSLog(@"InputAccessoryView释放了");
}

@end
