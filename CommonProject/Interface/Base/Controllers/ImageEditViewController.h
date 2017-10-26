//
//  ImageEditViewController.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^PushImageBlock)(UIImage *);
/**
 push这个控制器的时候需要传入字典，receivedData为一个字典{@"image":[UIImage *],
 @"size":[NSValue *],@"block":block}
 */
@interface ImageEditViewController : BaseViewController

@property (copy,nonatomic)PushImageBlock block;

@property (assign,nonatomic)CGSize size;

@end
