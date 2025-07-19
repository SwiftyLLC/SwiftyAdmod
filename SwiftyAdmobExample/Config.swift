//
//  Config.swift
//  SwiftyAdmobExample
//
//  Created SwiftyLLC Mobile on 9/4/24.
//

import Foundation


struct AdmobConfig {
    /*
     Định dạng quảng cáo                Mã đơn vị quảng cáo thử nghiệm
     Quảng cáo khi mở ứng dụng          ca-app-pub-3940256099942544/5575463023
     Biểu ngữ thích ứng                 ca-app-pub-3940256099942544/2435281174
     Biểu ngữ có kích thước cố định    ca-app-pub-3940256099942544/2934735716
     Quảng cáo xen kẽ                   ca-app-pub-3940256099942544/4411468910
     Quảng cáo có tặng thưởng           ca-app-pub-3940256099942544/1712485313
     Quảng cáo xen kẽ có tặng thưởng    ca-app-pub-3940256099942544/6978759866
     Gốc                                ca-app-pub-3940256099942544/3986624511
     Quảng cáo gốc dạng video           ca-app-pub-3940256099942544/2521693316
     */
    // https://developers.google.com/admob/ios/test-ads?hl=vi
    static let bannerId             = "ca-app-pub-3940256099942544/2934735716"
    static let adaptiveBannerId     = "ca-app-pub-3940256099942544/2435281174"
    static let nativeId             = "ca-app-pub-3940256099942544/2521693316"
    static let openAppId            = "ca-app-pub-3940256099942544/5575463023"
    static let fullScreenId         = "ca-app-pub-3940256099942544/4411468910"
    static let rewardId             = "ca-app-pub-3940256099942544/1712485313"
}
