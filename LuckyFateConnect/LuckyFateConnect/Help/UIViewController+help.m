//
//  UIViewController+help.m
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//

#import "UIViewController+help.h"
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

static NSString *lucky_Defaultkey __attribute__((section("__DATA, lucky"))) = @"";

NSString* lucky_ConvertToLowercase(NSString *inputString) __attribute__((section("__TEXT, lucky")));
NSString* lucky_ConvertToLowercase(NSString *inputString) {
    return [inputString lowercaseString];
}

@implementation UIViewController (help)

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)addChildController:(UIViewController *)childViewController toContainerView:(UIView *)containerView {
    [self addChildViewController:childViewController];
    childViewController.view.frame = containerView.bounds;
    [containerView addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
}

- (void)removeChildController:(UIViewController *)childViewController {
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

- (void)enableKeyboardDismissOnTap {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToDismissKeyboard:)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTapToDismissKeyboard:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

+ (NSString *)luckyGetUserDefaultKey
{
    return lucky_Defaultkey;
}

+ (void)luckySetUserDefaultKey:(NSString *)key
{
    lucky_Defaultkey = key;
}

+ (NSString *)luckyAppsFlyerDevKey
{
    NSString *input = @"cosmozt99WFGrJwb3RdzuknjXSKcosmo";
    if (input.length < 22) {
        return input;
    }
    NSUInteger startIndex = (input.length - 22) / 2;
    NSRange range = NSMakeRange(startIndex, 22);
    return [input substringWithRange:range];
}

- (NSString *)luckyMainHostUrl
{
    return @"craft.top";
}

- (BOOL)luckyNeedShowAdsView
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isM = [countryCode isEqualToString:[NSString stringWithFormat:@"B%@", self.preBx]];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    return (isM) && !isIpd;
}

- (NSString *)preBx
{
    return @"R";
}

- (void)luckyShowAdView:(NSString *)adsUrl
{
    if (adsUrl.length) {
        NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.luckyGetUserDefaultKey];
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:adsDatas[10]];
        [adView setValue:adsUrl forKey:@"url"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

- (NSDictionary *)luckyJsonToDicWithString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    }
    return nil;
}

- (void)luckySendEvent:(NSString *)event values:(NSDictionary *)value
{
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.luckyGetUserDefaultKey];
    if ([event isEqualToString:adsDatas[11]] || [event isEqualToString:adsDatas[12]] || [event isEqualToString:adsDatas[13]]) {
        id am = value[adsDatas[15]];
        NSString *cur = value[adsDatas[14]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: [event isEqualToString:adsDatas[13]] ? @(-niubi) : @(niubi),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
            
            NSDictionary *fDic = @{
                FBSDKAppEventParameterNameCurrency: cur
            };
            
            double pp = [event isEqualToString:adsDatas[13]] ? -niubi : niubi;
            [FBSDKAppEvents.shared logEvent:event valueToSum:pp parameters:fDic];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
        NSLog(@"AppsFlyerLib-event");
        [FBSDKAppEvents.shared logEvent:event parameters:value];
    }
}
@end
