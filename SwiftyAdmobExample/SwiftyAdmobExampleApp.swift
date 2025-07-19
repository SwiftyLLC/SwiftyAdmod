//
//  SwiftyAdmobExampleApp.swift
//  SwiftyAdmobExample
//
//  Created by Swifty LLC on 9/4/24.
//

import SwiftUI
import SwiftyAdmob

@main
struct SwiftyAdmobExampleApp: App {
    
    @Environment(\.colorScheme) private  var colorScheme
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            AdmobExampleView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appDelegate)
                .preferredColorScheme(.light)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("applicationDidBecomeActive")
                    appDelegate.applicationDidBecomeActive()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("applicationWillEnterForeground")
                    appDelegate.applicationWillEnterForeground()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    appDelegate.applicationDidEnterBackground()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                    appDelegate.applicationWillTerminate()
                }
                .onOpenURL { url in
                    
                }
        }
    }
}
