//
//  AdsInterstitial.swift
//  SwiftyAdmob
//
//  Created by Swifty LLC on 20/5/25.
//

import Foundation
import GoogleMobileAds

final public class AdmobInterstitial: NSObject, FullScreenContentDelegate {
    
    var interstitial: InterstitialAd?
    private var completeFullScreenAds: AdmobVoidComplete?
    
    public override init() {
        
    }

    public func loadAds(_ idAds: String, isShowNow: Bool = false, showComplete: AdmobVoidComplete? = nil) {
        if (interstitial != nil) {
            return
        }
        
        InterstitialAd.load(with: AdmobManager.shared().interstitialId,
                               request: AdmobManager.shared().makeRequest(),
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
                    
                    if isShowNow {
                        self.showAds(complete: showComplete)
                    }
                }
            }
        )
    }
    
    public func showAds(complete: AdmobVoidComplete? = nil) {
        self.completeFullScreenAds = complete
        if interstitial != nil {
            if let controller = UIApplication.shared.topMostViewController {
                interstitial?.present(from: controller)
            }
        } else {
            if let _action = complete {
                _action()
            }
        }
    }
    
    //MARK: - Delegate
    /// Tells the delegate that the ad failed to present full screen content.
    public func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        if (ad as? InterstitialAd) == self.interstitial {
            self.interstitial = nil
            if let complete = self.completeFullScreenAds {
                complete()
            }
        }
    }

    /// Tells the delegate that the ad will present full screen content.
    public func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    public func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        if (ad as? InterstitialAd)  == self.interstitial {
            self.interstitial = nil
            if let complete = self.completeFullScreenAds {
                complete()
            }
        }
    }
}
