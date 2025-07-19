//
//  RewardView.swift
//  SwiftyAdmobExample
//
//  Created by Swifty LLC on 10/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmob

class RewardViewModel: ObservableObject {
    @Published var isLoadingReward: Bool = false
    
    var admobRewarded: AdmobRewarded?
    
    deinit {
        print(">>> deinit RewardViewModel")
    }
    
    func onClickReward() {
        isLoadingReward = true
        admobRewarded = AdmobRewarded.init(
            rewardId: AdmobConfig.rewardId,
            loadCompletion: {[weak self] reward, err in
                guard let `self` = self else { return }
                DispatchQueue.main.async {
                    self.isLoadingReward.toggle()
                }
                
                if let err = err {
                    print("[RewardViewModel] ERROR --> " + err.localizedDescription)
                    return
                }
            },
            showAfterLoaded: true) { rewarded in
                print("[RewardViewModel] completion --> \(rewarded)")
            }
//        admobRewarded.completion = { success in
//            print("[RewardViewModel] completion --> \(success)")
//        }
        admobRewarded?.rewardFunction = { item in
            print("[RewardViewModel] rewardFunction --> \(item)")
        }
    }
}

struct RewardView: View {
    
    @State private var earnRewared: Bool = false
    
    @StateObject private var viewModel = RewardViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                SwiftyAdmob.showRewardAd {
                    print("SwiftyAdmob Reward ....")
                    print("....")
                    print("----> Earned Reward!")
                    print("....")
                    print("SwiftyAdmob Reward ....")
                } rewardComplete: { rewarded in
                    print("END ....")
                    print("----> rewardComplete dismiss with rewarded \(rewarded)")
                    print("END....")
                    
                    earnRewared = true

                }
            }, label: {
                Text("Show Reward")
                    .padding()
            })
            
            Text(earnRewared ? "Is Earn Rewared" : "Not ear reward")
                .padding(.bottom, 50)
            
            Button {
                viewModel.onClickReward()
                
            } label: {
                Text("Load and show Rewards")
            }
            
            if viewModel.isLoadingReward {
                ProgressView()
                    
            }
        }
    }
}

#Preview {
    RewardView()
}
