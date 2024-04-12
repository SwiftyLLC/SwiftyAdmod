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
            AdmodNativeView()
                .frame(maxWidth: .infinity)
                .frame(height: 450)
        }
    }
}

#Preview {
    BannerNativeView()
}
