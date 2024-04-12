//
//  InterstitialView.swift
//  SwiftyAdmodExample
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmod

struct InterstitialView: View {
    var body: some View {
        VStack {
            Button(action: {
                SwiftyAdmod.showInterstitial {
                    print("Interstitial  .....")
                    print("Interstitial  --> Dismiss complete")
                    print("Interstitial  .....")
                }
            }, label: {
                Text("Show Interstitial")
                    .padding()
            })
        }
    }
}

#Preview {
    InterstitialView()
}
