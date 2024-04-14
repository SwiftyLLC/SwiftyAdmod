//
//  Appdelegate.swift
//  SwiftyAdmodExample
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import Combine
import UIKit
import SwiftyAdmod
import GoogleMobileAds

class AppDelegate: NSObject, ObservableObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Start admod
        SwiftyAdmod.startWith(
            bannerId: AdmobConfig.bannerId,
            adaptiveBannerId: AdmobConfig.adaptiveBannerId,
            nativeBanner: AdmobConfig.nativeId,
            interstitialId: AdmobConfig.fullScreenId,
            rewardId: AdmobConfig.rewardId,
            openId: AdmobConfig.openAppId
        )
        SwiftyAdmod.configTestDevice(identifiers: ["9eb6fb21e592f1f37b96147f8356e9b0"])
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["9eb6fb21e592f1f37b96147f8356e9b0"]

        SwiftyAdmod.loadInterstitial()
        SwiftyAdmod.loadReward()
        
        SwiftyAdmod.loadConsentForm()
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Messaging.messaging().apnsToken = deviceToken
    }
        
    func applicationDidBecomeActive() {
        print("applicationDidBecomeActive")
        //tryToPresentAd
        SwiftyAdmod.showOpenApp()
    }
    
    func applicationDidEnterBackground() {
    }

    func applicationWillEnterForeground() {
        print("applicationWillEnterForeground")
        SwiftyAdmod.loadOpenApp()
    }

    func applicationWillTerminate() {
        print("applicationWillTerminate")
    }

}
