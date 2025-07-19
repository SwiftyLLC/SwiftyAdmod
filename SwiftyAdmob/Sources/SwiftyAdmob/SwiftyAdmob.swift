// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GoogleMobileAds
import UserMessagingPlatform

public typealias AdmobVoidComplete = () -> Void
public typealias AdmobBoolComplete = (_ rewarded: Bool) -> Void

public class SwiftyAdmob: NSObject {
    
    //MARK: - Private
    
    
    
    //MARK: - Function prepare for Admob
    public class func startWith(bannerId: String?, adaptiveBannerId: String?, nativeBanner: String?, interstitialId: String?, rewardId: String?, openId: String?) {
        MobileAds.shared.start(completionHandler: nil)
        
        AdmobManager.shared().bannerId = bannerId ?? ""
        AdmobManager.shared().bannerAdaptive = adaptiveBannerId ?? ""
        AdmobManager.shared().bannerNative = nativeBanner ?? ""
        AdmobManager.shared().interstitialId = interstitialId ?? ""
        AdmobManager.shared().rewardId = rewardId ?? ""
        AdmobManager.shared().openId = openId ?? ""
    }
    
    public class func loadConsentForm() {
        //Handle load form
        // Create a UMPRequestParameters object
        let parameters = RequestParameters()
        parameters.isTaggedForUnderAgeOfConsent = false

        // Request an update to the consent information
        ConsentInformation.shared.requestConsentInfoUpdate(with: parameters, completionHandler: { error in
            if error != nil {
                // Handle the error.
            } else {
                // The consent information state was updated. You are now ready to check if a form is available.
                let formStatus = ConsentInformation.shared.formStatus
                if formStatus == .available {
                    // Load the form
                    self.loadForm()
                }
            }
        })
    }
    
    // Load GDPR form
    class func loadForm() {
        ConsentForm.load { form, loadError in
            if loadError != nil {
                // Handle the error.
            } else {
                // Present the form. You can also hold on to the reference to present later.
                if ConsentInformation.shared.consentStatus == .required {
                    if let viewController = UIApplication.shared.topMostViewController {
                        form?.present(
                            from: viewController,
                            completionHandler: { dismissError in
                                if ConsentInformation.shared.consentStatus == .obtained {
                                    // App can start requesting ads.
                                }
                                // Handle dismissal by reloading form.
                                self.loadForm()
                            }
                        )
                    }
                } else {
                    // Keep the form available for changes to user consent.
                }
            }
        }
    }
    
    public class func configTestDevice(identifiers: [String]) {
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = identifiers
    }
    
    public class func configInterstitialCount(_ number: Int) {
        AdmobManager.shared().configInterstitialCount = number
    }
    
    /// Seconds value, default 10 minute
    public class func configOpenAppLimitTime(seconds: Int) {
        AdmobOpenApp.shared().configShowTime = seconds
    }
    
    /// Load Interstitial Ads
    /// if showAfterLoaded true ads will show immediate after loaded.
    public class func loadInterstitial(_ showAfterLoaded: Bool = false) {
        AdmobManager.shared().showInterstitialAfterLoaded = showAfterLoaded
        AdmobManager.shared().loadInterstitialAd()
    }
    
    public class func loadInterstitialWithCount() {
        AdmobManager.shared().loadInterstitialAdDiscover()
    }
    
    public class func loadReward() {
        AdmobManager.shared().loadRewardAd()
    }
    
    public class func loadOpenApp() {
        AdmobOpenApp.shared().requestOpenAppAds()
    }

    //MARK: - Function show Admob
    
    /// Show Reward and call back success or failed
    /// rewardFunction: call when Admob Ads return rewared
    /// rewardComplete: Call when Admob ads dismiss, return rewarded or not reward
    public class func showRewardAd(rewardFunction: @escaping AdmobVoidComplete, rewardComplete: @escaping AdmobBoolComplete) {
        AdmobManager.shared().showRewardAd(rewardFunction: rewardFunction, rewardComplete: rewardComplete)
    }
    
    public class func showInterstitial(complete: AdmobVoidComplete?) {
        AdmobManager.shared().showInterstitialAd(complete: complete)
    }
    
    public class func showInterstitialWithCount(complete: AdmobVoidComplete?) {
        AdmobManager.shared().showInterstitialAdDiscover(complete: complete)
    }

    public class func showOpenApp() {
        AdmobOpenApp.shared().tryToPresentAd()
    }
}

public extension SwiftyAdmob {
    class func loadAndShowReward() {
        
    }
}
