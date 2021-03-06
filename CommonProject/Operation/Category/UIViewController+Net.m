//
//  UIViewController+Net.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "UIViewController+Net.h"

@interface UIViewController () <YTKRequestDelegate,YTKChainRequestDelegate>
@property (copy,nonatomic,nullable)RequestBlock successBlock;

@property (copy,nonatomic,nullable)RequestBlock failureBlock;

@property (copy,nonatomic,nullable)BatchBlock chainArrayBlock;

@property (copy,nonatomic,nullable)BatchBlock chainFailedArrayBlock;

@property (copy,nonatomic,nullable)RequestBlock chainFailedBlck;
@end

@implementation UIViewController (Net)

#pragma mark —— 网络请求
#pragma mark - 基本的网络请求处理
- (void)startWithApi:(__kindof BaseRequestApi *)api completionBlockWithSuccess:(RequestBlock)successBlock failure:(RequestBlock)failureBlock {
    
    [QMUITips showLoadingInView:self.view];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        
        [self pritfReturnCodeStatus:request];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

- (void)starApi:(__kindof BaseRequestApi *)api requestFinished:(RequestBlock)successBlock requestFailed:(RequestBlock)failureBlock{
    [api start];
    
    [QMUITips showLoadingInView:self.view];
    self.successBlock = successBlock;
    
    self.failureBlock = failureBlock;
    
    api.delegate = self;
}

- (void)requestFinished:(__kindof BaseRequestApi *)request {
    if (self.successBlock!=nil) {
        self.successBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
- (void)requestFailed:(__kindof BaseRequestApi *)request {
    if (self.failureBlock!=nil) {
        self.failureBlock(request);
    }
    [self pritfReturnCodeStatus:request];
}
#pragma mark - 批量网络请求处理
- (void)batchRequestWithRequestArray:(NSArray <BaseRequestApi *> *)apiArray startWithCompletionBlockWithSuccess:(BatchBlock)successBlock failure:(BatchBlock)failureBlock failedRequest:(RequestBlock)failedRequestBlock{
    
    [QMUITips showLoadingInView:self.view];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apiArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (successBlock!=nil) {
            successBlock(requests);
        }
        BaseRequestApi * lastRequest = requests.lastObject;
        [self pritfReturnCodeStatus:lastRequest];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        if (failureBlock!=nil) {
            failureBlock(requests);
        }
        __kindof YTKRequest *failedRq = batchRequest.failedRequest;
        if (failedRequestBlock!=nil) {
            failedRequestBlock(failedRq);
        }
        [self pritfReturnCodeStatus:failedRq];
    }];
}


#pragma mark - 相互依赖的网络请求
- (void)chainRequestWithBaseRequset:(BaseRequestApi *)baseApi successThenSecondRequest:(ChainBlock_returnApi)blockthenSecondApi requestFinished:(RequestBlock)blockSecond{
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    [QMUITips showLoadingInView:self.view];
    @WeakObj(self);
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        @StrongObj(self);
        __kindof BaseRequestApi *secondReq = blockthenSecondApi(baseRequest);
        if(secondReq!=nil){
            @WeakObj(self);
            [chainRequest addRequest:secondReq callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
                @StrongObj(self);
                if (blockSecond!=nil) {
                    blockSecond(baseRequest);
                }
                [self pritfReturnCodeStatus:baseRequest];
            }];
        }else{
            [self pritfReturnCodeStatus:baseRequest];
        }
        
    }];
    [chainReq start];
}

- (void)chainRequestWithBaseRequset:(__kindof BaseRequestApi *)baseApi successThenRequestArray:(ChainBlock_returnArrayApi)blockthenApiArray chainRequestFinished:(BatchBlock)blockArray failed:(BatchBlock)failedblockArray failedBaseRequest:(RequestBlock)failedblock{
    
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    [QMUITips showLoadingInView:self.view];
    [chainReq addRequest:baseApi callback:^(YTKChainRequest * _Nonnull chainRequest,__kindof YTKBaseRequest * _Nonnull baseRequest) {
        NSArray <__kindof BaseRequestApi *> *arrRequest = blockthenApiArray(baseRequest);
        if (arrRequest!=nil) {
            [arrRequest enumerateObjectsUsingBlock:^(__kindof BaseRequestApi * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [chainRequest addRequest:obj callback:nil];
            }];
            self.chainArrayBlock = blockArray;
            self.chainFailedArrayBlock = failedblockArray;
            self.chainFailedBlck = failedblock;
        }
    }];
    chainReq.delegate = self;
    [chainReq start];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(__kindof YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    __kindof YTKBaseRequest *lastApi = chainRequest.requestArray.lastObject;
    if (self.chainArrayBlock!=nil) {
        self.chainArrayBlock(arrayM);
    }
    [self pritfReturnCodeStatus:lastApi];
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(__kindof YTKBaseRequest*)request {
    NSMutableArray *arrayM = [NSMutableArray array];
    [chainRequest.requestArray enumerateObjectsUsingBlock:^(YTKBaseRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [arrayM addObject:obj];
        }
    }];
    if (self.chainFailedArrayBlock!=nil) {
        self.chainFailedArrayBlock(arrayM);
    }
    if (self.chainFailedBlck!=nil) {
        self.chainFailedBlck(request);
    }
    [self pritfReturnCodeStatus:request];
    // some one of request is failed
}

#pragma 显示上次缓存的内容
- (void)loadCacheDataWith:(BaseRequestApi *)api dataWithCache:(RequestBlock)cacheBlock success:(RequestBlock)successBlock failure:(RequestBlock)failureBlock{
    if ([api loadCacheWithError:nil]) {
        if (cacheBlock!=nil) {
            cacheBlock(api);
        }
    }
    [QMUITips showLoadingInView:self.view];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (successBlock!=nil) {
            successBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    } failure:^(__kindof YTKBaseRequest *request) {
        if (failureBlock!=nil) {
            failureBlock(request);
        }
        [self pritfReturnCodeStatus:request];
    }];
}

#pragma mark - 打印回调状态
- (void)pritfReturnCodeStatus:(__kindof YTKRequest *)request{
    [self showErrorInfoOnKeyWindowHudWithRequest:request];
}
- (void)showErrorInfoOnKeyWindowHudWithRequest:(__kindof YTKRequest *)request{
    QMUITips *hud = [QMUITips toastInView:self.view];
    if ([request.responseObject[@"code"] integerValue]!=100&&request.responseObject) {
        [hud showWithText:request.responseObject[@"message"]];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [QMUITips hideAllToastInView:self.view animated:YES];
        });
    }else{
        [QMUITips hideAllToastInView:self.view animated:YES];
    }
}
@end

