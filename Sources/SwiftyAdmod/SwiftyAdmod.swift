// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GoogleMobileAds

public typealias AdmodVoidComplete = () -> Void
public typealias AdmodBoolComplete = (_ rewarded: Bool) -> Void

public class SwiftyAdmod: NSObject {
    //MARK: - Function prepare for Admod
    public class func startWith(bannerId: String?, adaptiveBannerId: String?, nativeBanner: String?, interstitialId: String?, rewardId: String?, openId: String?) {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        AdmodManager.shared().bannerId = bannerId ?? ""
        AdmodManager.shared().bannerAdaptive = adaptiveBannerId ?? ""
        AdmodManager.shared().bannerNative = nativeBanner ?? ""
        AdmodManager.shared().interstitialId = interstitialId ?? ""
        AdmodManager.shared().rewardId = rewardId ?? ""
        AdmodManager.shared().openId = openId ?? ""
    }
    
    public class func loadInterstitial(_ showAfterLoaded: Bool = false) {
        AdmodManager.shared().loadInterstitialAd()
    }
    
    public class func loadInterstitialWithCount(_ showAfterLoaded: Bool = false) {
        AdmodManager.shared().loadInterstitialAdDiscover()
    }
    
    public class func loadReward() {
        AdmodManager.shared().loadRewardAd()
    }
    
    public class func loadOpenApp(_ showAfterLoaded: Bool = false) {
        AdmodOpenApp.shared().requestAppOpenAd()
    }

    //MARK: - Function show Admod
    
    /// Show Reward and call back success or failed
    /// rewardFunction: call when Admod Ads return rewared
    /// rewardComplete: Call when Admod ads dismiss, return rewarded or not reward
    public class func showRewardAd(rewardFunction: @escaping AdmodVoidComplete, rewardComplete: @escaping AdmodBoolComplete) {
        AdmodManager.shared().showRewardAd(rewardFunction: rewardFunction, rewardComplete: rewardComplete)
    }
    
    public class func showInterstitial(complete: AdmodVoidComplete?) {
        AdmodManager.shared().showInterstitialAd(complete: complete)
    }
    
    public class func showOpenApp() {
        AdmodOpenApp.shared().tryToPresentAd()
    }
}
