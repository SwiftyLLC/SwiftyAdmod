//
//  AdsManager.swift
//

import Foundation
import GoogleMobileAds

class AdmodManager: NSObject, GADFullScreenContentDelegate {
    
    private static let sharedInstance = AdmodManager()
    
    static func shared() -> AdmodManager {
        return sharedInstance
    }
    
    //Id Ads
    var bannerId: String = ""
    var bannerAdaptive: String = ""
    var bannerNative: String = ""
    var interstitialId: String = ""
    var rewardId: String = ""
    var openId: String = ""
    
    var showInterstitialAfterLoaded = false
    
    var interstitial: GADInterstitialAd?
    private var completeFullScreenAds: AdmodVoidComplete?

    
    var configInterstitialCount: Int = 5
    private var countInterstitial: Int = 0
    private var interstitialDiscover: GADInterstitialAd?
    private var completeDiscover: AdmodVoidComplete?

    //Rewawrd
    var rewardedAds: AdmodRewarded?

    
    func showInterstitialAd(complete: AdmodVoidComplete? = nil) {
        completeFullScreenAds = complete;
        if interstitial != nil {
            if let controller = UIApplication.shared.topMostViewController {
                interstitial?.present(fromRootViewController: controller)
            } else {
                if let _action = complete {
                    _action()
                }
            }
        } else {
            if let _action = complete {
                _action()
            }
            loadInterstitialAd()
        }
    }
    
    //TODO: - update to bool
    func showInterstitialAdDiscover(complete: AdmodVoidComplete? = nil) {
        completeDiscover = complete
        if self.countInterstitial != 0 && interstitialDiscover != nil && self.countInterstitial <= configInterstitialCount {
            self.countInterstitial += 1
            if let _action = complete {
                _action()
            }
            return
        }
        if interstitialDiscover != nil {
            if let controller = UIApplication.shared.topMostViewController {
                interstitialDiscover?.present(fromRootViewController: controller)
                self.countInterstitial = 1
            } else {
                if let _action = complete {
                    _action()
                }
            }
        } else {
            if let _action = complete {
                _action()
            }
            loadInterstitialAdDiscover()
        }
    }
    
    /// Show Reward and call back success or failed
    /// rewardFunction: call when Admod Ads return rewared
    /// rewardComplete: Call when Admod ads dismiss, return rewarded or not reward
    func showRewardAd(rewardFunction: @escaping AdmodVoidComplete, rewardComplete: @escaping AdmodBoolComplete) {
        if rewardedAds == nil {
            rewardComplete(false)
            self.loadRewardAd()
            return
        }
        let result = rewardedAds?.showReward(rewardFunction: {
            rewardFunction()
        }, rewardComplete: { rewarded in
            rewardComplete(rewarded)
            self.loadRewardAd()
        })
        
        if result == false {
            rewardComplete(false)
            self.loadRewardAd()
        }
    }
    
    func makeRequest() -> GADRequest {
        let request = GADRequest()
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            request.scene = scene
        }
        return request
    }
        
    //private func
    func loadInterstitialAd() {
        if interstitial != nil {
            return
        }
        
        GADInterstitialAd.load(withAdUnitID: interstitialId,
                               request: self.makeRequest(),
            completionHandler: { [weak self] ad, error in
                guard let `self` = self else {
                    return
                }
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.interstitial = ad
                    self.interstitial?.fullScreenContentDelegate = self
                    print("loadInterstitialAd to load interstitial ad success!")
                    
                    if self.showInterstitialAfterLoaded {
                        self.showInterstitialAd()
                    }
                }
            }
        )
    }
    
    func loadInterstitialAdDiscover() {
        if interstitialDiscover != nil {
            return
        }

        GADInterstitialAd.load(withAdUnitID: interstitialId,
                               request: self.makeRequest(),
            completionHandler: { [weak self] ad, error in
                guard let `self` = self else {
                    return
                }
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.interstitialDiscover = ad
                    self.interstitialDiscover?.fullScreenContentDelegate = self
                    print("loadInterstitialAd to load interstitial ad success!")
                }
            }
        )
    }
    
    func loadRewardAd() {
        rewardedAds = AdmodRewarded(rewardId: rewardId)
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        if (ad as? GADInterstitialAd) == self.interstitial {
            self.interstitial = nil
            self.loadInterstitialAd()
            if let complete = self.completeFullScreenAds {
                complete()
            }
        }
        
        if (ad as? GADInterstitialAd) == self.interstitialDiscover {
            self.interstitialDiscover = nil
            self.loadInterstitialAdDiscover()
            if let complete = self.completeDiscover {
                complete()
            }
        }
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        if (ad as? GADInterstitialAd)  == self.interstitial {
            self.interstitial = nil
            self.loadInterstitialAd()
            if let complete = self.completeFullScreenAds {
                complete()
            }
        }
        
        if (ad as? GADInterstitialAd) == self.interstitialDiscover {
            self.interstitialDiscover = nil
            self.loadInterstitialAdDiscover()
            if let complete = self.completeDiscover {
                complete()
            }
        }
    }
    
    
}
