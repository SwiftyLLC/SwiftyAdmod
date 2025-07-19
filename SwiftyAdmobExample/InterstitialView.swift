//
//  InterstitialView.swift
//  SwiftyAdmobExample
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmob

struct InterstitialView: View {
    var body: some View {
        VStack {
            Button(action: {
                SwiftyAdmob.showInterstitial {
                    print("Interstitial  .....")
                    print("Interstitial  --> Dismiss complete")
                    print("Interstitial  .....")
                }
            }, label: {
                Text("Show Interstitial")
                    .padding()
            }).padding(.bottom, 80)
            
            
            Button {
//                AdmobInterstitial.ini
            } label: {
                Text("Load show now")
            }

            
        }
    }
}

#Preview {
    InterstitialView()
}
