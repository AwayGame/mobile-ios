//
//  AppDelegate.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import TwitterKit
import FBSDKCoreKit
import Firebase
import InstantSearch
import Kingfisher
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // TODO: POST RELEASE TODO LIST
    /*
     
     // ABSTRACT STYLING FUNCTIONALITY.. too much repeated code
     - Create custom label class
     - Create custom button class
     - Create custom view class
     - Create custom tableview classes that extend a custom base tableview class
     
     // DELEGATES
     - Better deleagation patterns
     - More organized code
     - Reduce delegates

     // NAMING CONVENTION
     - Better delegate naming convention
     - More consistent property naming
     
     // COMMENTS
     - Come up with a consistent commenting structure
 
     //...
     
     */
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        Twitter.sharedInstance().start(withConsumerKey: "PdYhw4Wp0TwWhWt3p8qQkGxW1", consumerSecret: "vRC2yHmkxpAGfCinYMGUz1VnOpsfJspHAcTkwP6wARprfYth6J")
        InstantSearch.shared.configure(appID: "PN1MFKMIA1", apiKey: "c9146d279765a93c33e343db249ab73a", index: "teams")
        
        return true
    }

    // MARK: - Facebook/Twitter
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.lowercased().range(of: "fb") != nil {
            let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
            return handled
        } else if url.absoluteString.lowercased().range(of: "twitter") != nil {
            return Twitter.sharedInstance().application(app, open: url, options: options)
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        AGAnalytics.logEvent(.appExited, parameters: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

