//
//  AdmobExampleView.swift
//  SwiftyAdmobExample
//
//  Created by SwiftyLLC on 9/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmob
import AppTrackingTransparency
import AdSupport

struct AdmobExampleView: View {
    var body: some View {
        TabView {
            HomeView()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SettingView().tag(1)
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
    }
}

#Preview {
    AdmobExampleView()
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Admob Example")
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
            .navigationTitle("SwiftyAdmob")
            .onAppear(perform: {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                  // Tracking authorization completed. Start loading ads here.
                  // loadAd()
                })
            })
        }
    }
}

struct SettingView: View {
    var body: some View {
        Text("Setting")
    }
}
