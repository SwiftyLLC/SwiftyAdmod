//
//  BannerView.swift
//  SwiftyAdmobExample
//
//  Created by Swifty LLC on 10/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmob
import GoogleMobileAds

struct BannerView: View {
    var body: some View {
        VStack {
            // Banner
            AdmobBannerView()
            
            // Data
            List {
                ForEach(0..<20, id: \.self) { index in
                    
                    if index == 4 {
                    }
                    Text("Item \(index)")
                        .padding()
                }
            }
            
            AdmobAdaptiveBannerView(size: currentOrientationInlineAdaptiveBanner(width: 320))

            //Adaptive banner
        }
    }
}

#Preview {
    BannerView()
}
