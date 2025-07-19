//
//  AdmobBannerView.swift
//
//
//  Created by Swifty LLC on 11/4/24.
//

import SwiftUI
import GoogleMobileAds

public struct AdmobBannerView : View {
    let size: AdSize
    public init(size: AdSize = AdSizeBanner) {
        self.size = size
    }
    
    public var body: some View {
        BannerAdsView(unitID: AdmobManager.shared().bannerId, size: size)
            .frame(maxWidth: .infinity)
            .frame(height:size.size.height)
    }
}

public struct AdmobAdaptiveBannerView : View {
    let size: AdSize
    public init(size: AdSize = AdSizeBanner) {
        self.size = size
    }
    
    public var body: some View {
        BannerAdsView(unitID: AdmobManager.shared().bannerAdaptive, size: size)
            .frame(maxWidth: .infinity, minHeight: 50.0)
    }
}


struct BannerAdsView: UIViewRepresentable {

    var unitID: String
    var size: AdSize

    func makeCoordinator() -> Coordinator {
        // For Implementing Delegates..
        return Coordinator()
    }

    func makeUIView(context: Context) -> BannerView{
        let adView = BannerView(adSize: size)

        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.topMostViewController ?? UIApplication.shared.getRootViewController()

        adView.load(AdmobManager.shared().makeRequest())

        return adView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {

    }

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: BannerView) {
            print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: BannerView) {
            print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: BannerView) {
            print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: BannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}
