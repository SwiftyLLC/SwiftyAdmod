//
//  BannerView.swift
//  SwiftyAdmodExample
//
//  Created by Swifty LLC on 10/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmod
import GoogleMobileAds

struct BannerView: View {
    var body: some View {
        VStack {
            // Banner
            AdmodBannerView()
            
            // Data
            List {
                ForEach(0..<20, id: \.self) { index in
                    
                    if index == 4 {
                    }
                    Text("Item \(index)")
                        .padding()
                }
            }
            
            AdmodAdaptiveBannerView(size: GADCurrentOrientationInlineAdaptiveBannerAdSizeWithWidth(320))

            //Adaptive banner
        }
    }
}

#Preview {
    BannerView()
}
