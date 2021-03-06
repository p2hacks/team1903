//
//  AppDelegate.swift
//  FrontDemo
//
//  Created by 猪飼　立晟 on 2019/02/16.
//  Copyright © 2019年 Tatsuika. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func gotoMainStoryBoard(){
        //let flg = false//分岐条件
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle:nil)
        let viewController:UIViewController
        
        //表示するビューコントローラーを指定
        if launchedBefore {
            viewController = storyboard.instantiateViewController(withIdentifier: "Chat") as UIViewController
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: "Tutorial") as UIViewController
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        window?.rootViewController = viewController
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        gotoMainStoryBoard()
        
        return true
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

