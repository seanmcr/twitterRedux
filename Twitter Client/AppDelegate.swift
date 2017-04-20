//
//  AppDelegate.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainStoryboard: UIStoryboard! = UIStoryboard(name: "Main", bundle: Bundle.main)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        navigateToHomeTimelineIfLoggedIn()
        NotificationCenter.default.addObserver(self, selector: #selector(onUserDidLogOut), name: TwitterClient.userDidLogOutNotification, object: nil)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let oauthCred = BDBOAuth1Credential(queryString: url.query!)
        TwitterClient.sharedInstance.login(withCredential: oauthCred, completion: { (user) in
            self.navigateToHomeTimelineIfLoggedIn()
        })
        return true
    }
    
    private func navigateToHomeTimelineIfLoggedIn(){
        if (TwitterClient.sharedInstance.isAuthorized){
            if (User.current != nil){
                let hamburgerMenuController = self.mainStoryboard.instantiateViewController(withIdentifier: "HamburgerMenuViewController")
                self.window!.rootViewController = hamburgerMenuController
            }
        }
    }
    
    @objc private func onUserDidLogOut(){
        self.window!.rootViewController = self.mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

