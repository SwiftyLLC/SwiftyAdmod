//
//  AdmodRewarded.swift
//
//
//  Created by SwiftyLLC on 11/4/24.
//

import Foundation
import GoogleMobileAds

final class AdmodRewarded: NSObject, GADFullScreenContentDelegate {
    
    var rewardedAd: GADRewardedAd?
    
    private var isEarnRewarded: Bool = false
    private var completion: AdmodBoolComplete?
    
    init(rewardId: String) {
        super.init()
        loadReward(rewardId)
    }
    
    func loadReward(_ rewardId: String){
        let request = GADRequest()
        // add extras here to the request, for example, for not presonalized Ads
        GADRewardedAd.load(withAdUnitID: rewardId, request: request, completionHandler: {rewardedAd, error in
            if error != nil {
                // loading the rewarded Ad failed :(
                print("ADS LOADING: error \(String(describing: error?.localizedDescription))")
                return
            }
            print("ADS LOADING: SUCCESS")
            self.rewardedAd = rewardedAd
        })
    }
    
    func showReward(rewardFunction: @escaping AdmodVoidComplete, rewardComplete: @escaping AdmodBoolComplete) -> Bool {
        guard let rewardedAd = rewardedAd else {
            return false
        }
        
        guard let root = UIApplication.shared.keyWindowPresentedController else {
            return false
        }
        self.isEarnRewarded = false
        //Save for dismis and callback
        self.completion = rewardComplete
        
        rewardedAd.fullScreenContentDelegate = self
        rewardedAd.present(fromRootViewController: root) {
            rewardFunction()
            // Ok reward
            self.isEarnRewarded = true
        }
        return true
    }
    
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        debugPrint("adDidDismissFullScreenContent ---->")
        if let action = self.completion {
            debugPrint("adDidDismissFullScreenContent ----> CALLBACK REWARED...")
            action(self.isEarnRewarded)
        }
    }
    
    func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        
    }
}
