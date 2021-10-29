//
//  AppDelegate.swift
//  Login_Naver_Example
//
//  Created by SG on 2021/10/28.
//

import UIKit
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
              NaverThirdPartyLoginConnection.getSharedInstance().isInAppOauthEnable = true
              NaverThirdPartyLoginConnection.getSharedInstance().isNaverAppOauthEnable = true

              let instance = NaverThirdPartyLoginConnection.getSharedInstance()
              instance?.isNaverAppOauthEnable = true
              instance?.isInAppOauthEnable = true

              instance?.serviceUrlScheme = kServiceAppUrlScheme
              instance?.consumerKey = kConsumerKey
              instance?.consumerSecret = kConsumerSecret
              instance?.appName = kServiceAppName
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
     
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
          return true
    }

}
