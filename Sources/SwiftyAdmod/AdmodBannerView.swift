//
//  AdmodBannerView.swift
//
//
//  Created by Swifty LLC on 11/4/24.
//

import SwiftUI
import GoogleMobileAds

public struct AdmodBannerView : View {
    let size: GADAdSize
    public init(size: GADAdSize = GADAdSizeBanner) {
        self.size = size
    }
    
    public var body: some View {
        BannerAdsView(unitID: AdmodManager.shared().bannerId, size: size)
            .frame(maxWidth: .infinity)
            .frame(height:size.size.height)
    }
}

public struct AdmodAdaptiveBannerView : View {
    let size: GADAdSize
    public init(size: GADAdSize = GADAdSizeBanner) {
        self.size = size
    }
    
    public var body: some View {
        BannerAdsView(unitID: AdmodManager.shared().bannerAdaptive, size: size)
            .frame(maxWidth: .infinity, minHeight: 50.0)
    }
}


struct BannerAdsView: UIViewRepresentable {

    var unitID: String
    var size: GADAdSize

    func makeCoordinator() -> Coordinator {
        // For Implementing Delegates..
        return Coordinator()
    }

    func makeUIView(context: Context) -> GADBannerView{
        let adView = GADBannerView(adSize: size)

        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.topMostViewController ?? UIApplication.shared.getRootViewController()

        adView.load(AdmodManager.shared().makeRequest())

        return adView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {

    }

    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}
