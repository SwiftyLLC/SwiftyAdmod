// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GoogleMobileAds
import UserMessagingPlatform

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
    
    public class func loadConsentForm() {
        //Handle load form
        // Create a UMPRequestParameters object
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

        // Request an update to the consent information
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters, completionHandler: { error in
            if error != nil {
                // Handle the error.
            } else {
                // The consent information state was updated. You are now ready to check if a form is available.
                let formStatus = UMPConsentInformation.sharedInstance.formStatus
                if formStatus == .available {
                    // Load the form
                    self.loadForm()
                }
            }
        })
    }
    
    // Load GDPR form
    class func loadForm() {
        UMPConsentForm.load { form, loadError in
            if loadError != nil {
                // Handle the error.
            } else {
                // Present the form. You can also hold on to the reference to present later.
                if UMPConsentInformation.sharedInstance.consentStatus == .required {
                    if let viewController = UIApplication.shared.keyWindowPresentedController {
                        form?.present(
                            from: viewController,
                            completionHandler: { dismissError in
                                if UMPConsentInformation.sharedInstance.consentStatus == .obtained {
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
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = identifiers
    }
    
    public class func configInterstitialCount(_ number: Int) {
        AdmodManager.shared().configInterstitialCount = number
    }
    
    /// Seconds value, default 10 minute
    public class func configOpenAppLimitTime(seconds: Int) {
        AdmodOpenApp.shared().configShowTime = seconds
    }
    
    /// Load Interstitial Ads
    /// if showAfterLoaded true ads will show immediate after loaded.
    public class func loadInterstitial(_ showAfterLoaded: Bool = false) {
        AdmodManager.shared().showInterstitialAfterLoaded = showAfterLoaded
        AdmodManager.shared().loadInterstitialAd()
    }
    
    public class func loadInterstitialWithCount() {
        AdmodManager.shared().loadInterstitialAdDiscover()
    }
    
    public class func loadReward() {
        AdmodManager.shared().loadRewardAd()
    }
    
    public class func loadOpenApp() {
        AdmodOpenApp.shared().requestOpenAppAds()
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
