//
//  AdmodOpenApp.swift
//
//
//  Created by SwiftyLLC on 11/4/24.
//

import Foundation
import GoogleMobileAds

final class AdmodOpenApp: NSObject, GADFullScreenContentDelegate {
    
    private static let sharedInstance = AdmodOpenApp()
    
    static func shared() -> AdmodOpenApp {
        return sharedInstance
    }

    /// Seconds, default 10m
    var configShowTime: Int = 10 * 60
    
    //Open app Ads
    var appOpenAd: GADAppOpenAd?
    private var loadTime: Date = Date.now
    private var displayOpenAdsTime: Date?
    
    func requestOpenAppAds() {
        if self.appOpenAd != nil && self.wasLoadTimeLessThanNHoursAgo(n: 4, date: self.loadTime) {
            print("[AdmodOpenApp] -- open app ads loaded, cancel request new ads")
            return
        }
        self.appOpenAd = nil;
        GADAppOpenAd.load(withAdUnitID: AdmodManager.shared().openId, request: AdmodManager.shared().makeRequest()) { ads, err in
            if (err != nil) {
                debugPrint("Failed to load app open ad: \(String(describing: err))")
                return;
            } else {
                debugPrint("-----> Load ads OPEN APP success")
                DispatchQueue.main.async {
                    self.appOpenAd = ads;
                    self.appOpenAd?.fullScreenContentDelegate = self
                    self.loadTime = Date.now
                }
            }
        }
    }
    
    func tryToPresentAd() {
        guard let root = UIApplication.shared.keyWindowPresentedController else {
            return
        }

        //check time ads expired
        if self.appOpenAd != nil && self.wasLoadTimeLessThanNHoursAgo(n: 4, date: self.loadTime) {
            if let date = self.displayOpenAdsTime {
                if self.wasLoadTimeLessThanSecondAgo(n: self.configShowTime, date: date) {
                    debugPrint("[OPEN ADS] Cancel show Ads open App present on configShowTime \(configShowTime) seconds")
                    return
                }
            }
            self.appOpenAd?.present(fromRootViewController: root)
            self.displayOpenAdsTime = Date.now
        } else {
            // If you don't have an ad ready, request one.
            self.requestOpenAppAds()
        }
    }
    
    //Ads delegate
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.requestOpenAppAds()
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adWillPresentFullScreenContent")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        debugPrint("adDidDismissFullScreenContent")
        self.requestOpenAppAds()
    }
    
    // MARK: - Private function
    
    private func wasLoadTimeLessThanNHoursAgo(n : Int, date: Date) -> Bool {
        let now = NSDate.now
        let timeIntervalBetweenNowAndLoadTime: TimeInterval = now.timeIntervalSince(date)
        //NSTimeInterval timeIntervalBetweenNowAndLoadTime = [now timeIntervalSinceDate:self.loadTime];
        let secondsPerHour: Double = 3600.0
        let intervalInHours: Double = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return intervalInHours < Double(n)
    }

    private func wasLoadTimeLessThanSecondAgo(n : Int, date: Date) -> Bool {
        let now = NSDate.now
        let timeIntervalBetweenNowAndLoadTime: TimeInterval = now.timeIntervalSince(date)
//        let secondsPerHour: Double = 3600.0
//        let intervalInHours: Double = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return timeIntervalBetweenNowAndLoadTime < Double(n)
    }
}
