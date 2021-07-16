//
//  ProductivApp.swift
//  Shared
//
//  Created by Dev Patel on 7/6/21.
//

import SwiftUI
import Firebase

@main
struct ProductivApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
                        
            ContentView()
                .environmentObject(viewModel)
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    }

}
