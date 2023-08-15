//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import SwiftUI
import FirebaseCore


@main
struct CryptoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
           LoginPageDesign()
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
