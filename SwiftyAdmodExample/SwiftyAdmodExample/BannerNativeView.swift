//
//  BannerNativeView.swift
//  SwiftyAdmodExample
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import SwiftUI
import SwiftyAdmod

struct BannerNativeView: View {
    var body: some View {
        VStack {
            // Data
            List {
                ForEach(0..<20, id: \.self) { index in
                    
                    if index == 4 {
                        AdmodNativeView()
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 330, maxHeight: 440)
                            .padding(10)
                    }
                    Text("Item \(index)")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    BannerNativeView()
}
