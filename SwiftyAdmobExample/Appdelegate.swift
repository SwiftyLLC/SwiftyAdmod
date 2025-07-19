//
//  Appdelegate.swift
//  SwiftyAdmobExample
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import Combine
import UIKit
import SwiftyAdmob
import GoogleMobileAds

class AppDelegate: NSObject, ObservableObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Start Admob
        SwiftyAdmob.startWith(
            bannerId: AdmobConfig.bannerId,
            adaptiveBannerId: AdmobConfig.adaptiveBannerId,
            nativeBanner: AdmobConfig.nativeId,
            interstitialId: AdmobConfig.fullScreenId,
            rewardId: AdmobConfig.rewardId,
            openId: AdmobConfig.openAppId
        )
        SwiftyAdmob.configTestDevice(identifiers: ["9eb6fb21e592f1f37b96147f8356e9b0", "6f74e5a14822ebe0a0ec94f45b12797e"])
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["9eb6fb21e592f1f37b96147f8356e9b0"]

//        SwiftyAdmob.loadInterstitial()
//        SwiftyAdmob.loadReward()
        
        SwiftyAdmob.loadConsentForm()
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Messaging.messaging().apnsToken = deviceToken
    }
        
    func applicationDidBecomeActive() {
        print("applicationDidBecomeActive")
        //tryToPresentAd
        SwiftyAdmob.showOpenApp()
    }
    
    func applicationDidEnterBackground() {
    }

    func applicationWillEnterForeground() {
        print("applicationWillEnterForeground")
        SwiftyAdmob.loadOpenApp()
    }

    func applicationWillTerminate() {
        print("applicationWillTerminate")
    }

}
