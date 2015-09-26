//
//  InAppUtils.h
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/9/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//
#import <StoreKit/StoreKit.h>
UIKIT_EXTERN NSString *const IAUtilsProductPurchasedNotification;
UIKIT_EXTERN NSString *const IAUtilsFailedProductPurchasedNotification;
@interface InAppUtils : NSObject <SKPaymentTransactionObserver,SKProductsRequestDelegate>
+(id)sharedInAppUtils;
-(void)removeAds:(NSString*)inAppID;
-(void)restorePurchase;
@end
