//
//  LeafApp.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI
import FirebaseCore

@main
struct LeafApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
//                    .navigationTitle("Leaf")
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
