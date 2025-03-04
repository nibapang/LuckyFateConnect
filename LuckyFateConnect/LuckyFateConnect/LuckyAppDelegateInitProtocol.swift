//
//  CosmoRabbitAppDelegateInitProtocol.swift
//  LuckyFateConnect
//
//  Created by jin fu on 2025/3/4.
//


import FirebaseCore
import FirebaseMessaging
import AppsFlyerLib
import FBSDKCoreKit

let appid = "6742787114"

protocol LuckyAppDelegateInitProtocol {
    func luckyInitFB(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func luckyInitFireBaseAnalyze()
    func luckyInitAppsFlyer()
    func luckyInitPush()
}

extension LuckyAppDelegateInitProtocol {
    
    func luckyInitFB(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
    }
    
    func luckyInitFireBaseAnalyze() {
        FirebaseApp.configure()
    }
    
    func luckyInitAppsFlyer() {
        let appsFlyer = AppsFlyerLib.shared()
        appsFlyer.appsFlyerDevKey = UIViewController.luckyAppsFlyerDevKey()
        appsFlyer.appleAppID = appid
        appsFlyer.waitForATTUserAuthorization(timeoutInterval: 51)
        appsFlyer.delegate = self as? any AppsFlyerLibDelegate
    }
    
    func luckyInitPush() {
        UNUserNotificationCenter.current().delegate = self as? any UNUserNotificationCenterDelegate
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        UIApplication.shared.registerForRemoteNotifications()
    }
}
