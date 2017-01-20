//
//  AppDelegate.swift
//  SwiftSample
//
//  Copyright © 2015 Freshdesk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        
        self.hotlineIntegration()
        
        /* Enable remote notifications */
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        return true
    }
    
    func hotlineIntegration(){
        
        
        // You can get the appId and appKey from https://web.hotline.io/settings/apisdk
        
        let config = HotlineConfig.init(appID: "<#<APP ID>#>", andAppKey: "<#<APP KEY>#>")
        
        config.agentAvatarEnabled = false;
        config.voiceMessagingEnabled = true;
        
        /*
        * Following three methods are to identify a user.
        * These user properties will be viewable on the Hotline web dashboard.
        * The externalID (identifier) set will also be used to identify the specific user for any APIs
        * targeting a user or list of users in pro-active messaging or marketing
        */
        
        // Create a user object
        let user =  HotlineUser.sharedInstance();
        //config.themeName = "<Theme Name>"
        // To set an identifiable name for the user
        user.name = "John Doe";
        
        //To set user's email id
        user.email = "john.doe.1982@example.com";
        
        //To set user's phone number
        user.phoneCountryCode="91";
        user.phoneNumber = "9790987495";
        
        //To set user's identifier (external id to map the user to a user in your system. Setting an external ID is COMPULSARY for many of Hotline’s APIs
        user.externalID="john.doe.82";
        
        // FINALLY, REMEMBER TO SEND THE USER INFORMATION SET TO HOTLINE SERVERS
        
        Hotline.sharedInstance().updateUser(user)
        
        /* Custom properties & Segmentation - You can add any number of custom properties. An example is given below.
        These properties give context for your conversation with the user and also serve as segmentation criteria for your marketing messages */
        
        //You can set custom user properties for a particular user
        Hotline.sharedInstance().updateUserPropertyforKey("plan", withValue: "Enterprise")
        
        //You can set user demographic information
        Hotline.sharedInstance().updateUserPropertyforKey("city", withValue: "San Bruno")
        
        //You can segment based on where the user is in their journey of using your app
        Hotline.sharedInstance().updateUserPropertyforKey("paid_user", withValue: "true")
        
        //You can capture a state of the user that includes what the user has done in your app
        Hotline.sharedInstance().updateUserPropertyforKey("transaction_count", withValue: "2")
        
        /* Managing Badge number for unread messages - Manual
        If you want to listen to a local notification and take care of updating the badge number yourself, listen for a notification with name "HOTLINE_UNREAD_MESSAGE_COUNT " as below
        */
        Hotline.sharedInstance().initWithConfig(config)
        print("Unread messages count \(Hotline.sharedInstance().unreadCount()) .")
        
        
        /* If you want to indicate to the user that he has unread messages in his inbox, you can retrieve the unread count to display. */
        Hotline.sharedInstance().unreadCountWithCompletion { (count:Int) -> Void in
            print("Unread count (Async) :\(count)")
        }
        
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Hotline.sharedInstance().updateDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Couldn't register: \(error)")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("didReceiveRemoteNotification")
        if Hotline.sharedInstance().isHotlineNotification(userInfo){
            
            Hotline.sharedInstance().handleRemoteNotification(userInfo, andAppstate: application.applicationState)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        let unreadCount : NSInteger = Hotline.sharedInstance().unreadCount()
        UIApplication.sharedApplication().applicationIconBadgeNumber = unreadCount;
    }
    
}
