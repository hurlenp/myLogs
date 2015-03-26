//
//  AppDelegate.swift
//  myLogs
//
//  Created by Neil Hurley on 3/13/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import UIKit
//#import <FBSDKCoreKit/FBSDKCoreKit.h>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("dSHFoG4j7uVFR9j6er3qnWvRmPNX1iGX6m4zM7DY",
            clientKey: "1jHWX6zP0AZqWF8B4DJ3ro9atbJ8q3KSuFXYO0bk")
        
        var object = PFObject(className: "myLogTest")
        
        //object.addObject("John's Butt", forKey: "websiteUrl")
        
        //object.addObject("Hello", forKey: "websiteRating")
        
        //object.save()
        
        
        /*FB
        FBLoginView.self
        FBProfilePictureView.self
        */
        
        
        
        // Override point for customization after application launch.
        return true
    }
    
    /*FB func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        
        FBvar wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled

    }*/

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

