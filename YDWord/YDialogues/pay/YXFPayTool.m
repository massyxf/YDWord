//
//  YXFPayTool.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YXFPayTool.h"
#import <StoreKit/StoreKit.h>

@interface YXFPayTool ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

/** success*/
@property(nonatomic,copy)YXFPayBlock success;

/** fail*/
@property(nonatomic,copy)YXFPayBlock fail;

@end

@implementation YXFPayTool

+(instancetype)shareInstance
{
    static YXFPayTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(void)buyProduct:(NSString *)productId success:(YXFPayBlock)success fail:(YXFPayBlock)fail
{
    if ([SKPaymentQueue canMakePayments]) {
        //允许程序内付费购买
        self.success = success;
        self.fail = fail;
        [self requestProductData:productId];
    }else{
        NSError *error = [NSError errorWithCode:YXFPayError text:@"不允许程序内付费购买"];
        fail(nil,error);
        NSLog(@"不允许程序内付费购买");
    }
}

//请求对应的产品信息
-(void)requestProductData:(NSString *)productId{
    NSSet *set = [NSSet setWithObject:productId];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0){
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败。");
        return;
    }
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    // populate UI
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    NSLog(@"---------发送购买请求------------");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
}

#pragma mark - SKPaymentTransactionObserver
// 处理交易结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    BOOL transFinished = YES;
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing://正在交易
                transFinished = NO;
                break;
            case SKPaymentTransactionStateDeferred://支付状态未确定
                //iOS 8.0后添加  待研究
                break;
            default:
                break;
        }
        if (transFinished) {
            // Remove the transaction from the payment queue.
            // 交易的结果返回后必须要加上这句
            [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
        }
    }
}

// 交易完成
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSString * productIdentifier = transaction.payment.productIdentifier;
    //    NSString * receipt = [transaction.transactionReceipt base64EncodedString];
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
    }
}

// 交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"用户取消交易");
    }
}

// 已购商品
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
}

@end
