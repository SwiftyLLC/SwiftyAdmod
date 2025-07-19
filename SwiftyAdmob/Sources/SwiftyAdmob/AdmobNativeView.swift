//
//  AdmobNativeView.swift
//
//
//  Created by Swifty LLC on 11/4/24.
//

import Foundation
import SwiftUI

public struct AdmobNativeView : UIViewControllerRepresentable {
    
    public init() {
        
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        let viewController = GADNativeViewController()
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
}
