//
//  RewardView.swift
//  SwiftyAdmodExample
//
//  Created by Swifty LLC on 10/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmod

struct RewardView: View {
    
    @State private var earnRewared: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                SwiftyAdmod.showRewardAd {
                    print("SwiftyAdmod Reward ....")
                    print("....")
                    print("----> Earned Reward!")
                    print("....")
                    print("SwiftyAdmod Reward ....")
                } rewardComplete: { rewarded in
                    print("END ....")
                    print("----> rewardComplete dismiss with rewarded \(rewarded)")
                    print("END....")

                }
            }, label: {
                Text("Show Reward")
                    .padding()
            })
            
            Text(earnRewared ? "Is Earn Rewared" : "Not ear reward")
        }
    }
}

#Preview {
    RewardView()
}
