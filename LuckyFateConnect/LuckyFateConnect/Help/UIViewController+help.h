//
//  UIViewController+help.h
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (help)

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)addChildController:(UIViewController *)childViewController toContainerView:(UIView *)containerView;

- (void)removeChildController:(UIViewController *)childViewController;

- (void)enableKeyboardDismissOnTap;

+ (NSString *)luckyGetUserDefaultKey;

+ (void)luckySetUserDefaultKey:(NSString *)key;

- (void)luckySendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)luckyAppsFlyerDevKey;

- (NSString *)luckyMainHostUrl;

- (BOOL)luckyNeedShowAdsView;

- (void)luckyShowAdView:(NSString *)adsUrl;

- (NSDictionary *)luckyJsonToDicWithString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
