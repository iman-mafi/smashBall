//
//  InAppUtils.m
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/9/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import "InAppUtils.h"
#import "Constants.h"

NSString *const IAUtilsProductPurchasedNotification = @"IAUtilsProductPurchasedNotification";
NSString *const IAUtilsFailedProductPurchasedNotification = @"IAUtilsFailedProductPurchasedNotification";
@implementation InAppUtils{
    bool _transactionGoing;
}
#pragma mark - Initialization -
+(id)sharedInAppUtils{
    static InAppUtils *sharedInAppUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInAppUtils = [[self alloc] init];
    });
    return sharedInAppUtils;
}
-(id)init{
    if (self=[super init]) {
        _transactionGoing = false;
        [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
    }
    return self;
}
-(void)removeAds:(NSString *)inAppID{
    if (!_transactionGoing) {
        SKProductsRequest *request= [[SKProductsRequest alloc]
                                     initWithProductIdentifiers: [NSSet setWithObject:inAppID]];
        request.delegate = self;
        [request start];
        _transactionGoing = true;
    }
}
-(void)restorePurchase{
    if (!_transactionGoing) {
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
        _transactionGoing = true;
    }
}
#pragma mark - StoreKit Methods -
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *myProduct = response.products;
    if ([myProduct count] > 0) {
        NSLog(@"%@",[[myProduct objectAtIndex:0] productIdentifier]);
        
        NSDecimalNumber *price = [[myProduct objectAtIndex:0] price];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:[[myProduct objectAtIndex:0] priceLocale]];
        NSString *formattedString = [numberFormatter stringFromNumber:price];
        [numberFormatter release];
        NSLog(@"Price: %@",formattedString);
        if ([SKPaymentQueue canMakePayments]) {
            SKPayment *newPayment = [SKPayment paymentWithProduct:[myProduct objectAtIndex:0]];
            [[SKPaymentQueue defaultQueue] addPayment:newPayment];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Your Device Limited" message:@"we have noticed that you device restrictions setting are currently limited. you can change it by going to Settings -> General -> Restrictions and turn it off" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
            
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification" message:@"In app purchases comming soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        [[NSNotificationCenter defaultCenter]postNotificationName:IAUtilsFailedProductPurchasedNotification object:nil];
    }
}
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    _transactionGoing = false;
    [[NSNotificationCenter defaultCenter]postNotificationName:IAUtilsFailedProductPurchasedNotification object:nil];
}
- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    if (queue.transactions.count > 0) {
        return;
    }
    else {
        [[NSNotificationCenter defaultCenter]postNotificationName:IAUtilsFailedProductPurchasedNotification object:nil];
        _transactionGoing = false;
    }
}
#pragma mark - Transaction State Handlers -
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Completed");
    // You can create a method to record the transaction.
    // [self recordTransaction: transaction];
    NSLog(@"Identifier %@",transaction.transactionIdentifier);
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isPurchased"];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    _transactionGoing = false;

    [[NSNotificationCenter defaultCenter] postNotificationName:IAUtilsProductPurchasedNotification object:nil];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    _transactionGoing = false;
     [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isPurchased"];
    [[NSNotificationCenter defaultCenter] postNotificationName:IAUtilsProductPurchasedNotification object:nil];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Unsuccessful"
                                                        message:@"Your purchase failed. Please try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    _transactionGoing = false;
    [[NSNotificationCenter defaultCenter]postNotificationName:IAUtilsFailedProductPurchasedNotification object:nil];
    
}
@end
