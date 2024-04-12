//
//  AdmodExampleView.swift
//  SwiftyAdmodExample
//
//  Created by SwiftyLLC on 9/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmod
import AppTrackingTransparency
import AdSupport

struct AdmodExampleView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Admod Example")
                    .frame(maxWidth: .infinity, alignment: .leading)
                List {
                    NavigationLink {
                        BannerView()
                    } label: {
                        Text("Banner, Adaptive banner")
                    }
                    
                    NavigationLink {
                        BannerNativeView()
                    } label: {
                        Text("Banner Native")
                    }
                    
                    NavigationLink {
                        InterstitialView()
                    } label: {
                        Text("Interstitial")
                    }
                    
                    NavigationLink {
                        RewardView()
                    } label: {
                        Text("Reward")
                    }

                }
            }
            .padding(20)
            .navigationTitle("SwiftyAdmod")
            .onAppear(perform: {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                  // Tracking authorization completed. Start loading ads here.
                  // loadAd()
                })
            })
        }
    }
}

#Preview {
    AdmodExampleView()
}
