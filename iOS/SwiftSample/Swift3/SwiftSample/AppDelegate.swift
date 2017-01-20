//
//  AppDelegate.swift
//  SwiftSample
//
//  Created by Sanjith J K on 17/01/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.

        self.hotlineIntegration()

        /* Enable remote notifications */
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.registerForRemoteNotifications()

        return true
    }

    func hotlineIntegration(){

        // You can get the appId and appKey from https://web.hotline.io/settings/apisdk

        let config = HotlineConfig.init(appID: "<#<APP ID>#>", andAppKey: "<#<APP KEY>#>")

        config?.agentAvatarEnabled = false;
        config?.voiceMessagingEnabled = true;

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
        user?.name = "John Doe";

        //To set user's email id
        user?.email = "john.doe.1982@example.com";

        //To set user's phone number
        user?.phoneCountryCode="91";
        user?.phoneNumber = "9790987495";

        //To set user's identifier (external id to map the user to a user in your system. Setting an external ID is COMPULSARY for many of Hotline’s APIs
        user?.externalID="john.doe.82";

        // FINALLY, REMEMBER TO SEND THE USER INFORMATION SET TO HOTLINE SERVERS

        Hotline.sharedInstance().update(user)

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
        Hotline.sharedInstance().initWith(config)
        print("Unread messages count \(Hotline.sharedInstance().unreadCount()) .")


        /* If you want to indicate to the user that he has unread messages in his inbox, you can retrieve the unread count to display. */
        Hotline.sharedInstance().unreadCount(completion: { (count:Int) -> Void in
            print("Unread count (Async) :\(count)")
        });


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
        let unreadCount : NSInteger = Hotline.sharedInstance().unreadCount()
        UIApplication.shared.applicationIconBadgeNumber = unreadCount;
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Hotline.sharedInstance().updateDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("didReceiveRemoteNotification")
        if Hotline.sharedInstance().isHotlineNotification(userInfo){

            Hotline.sharedInstance().handleRemoteNotification(userInfo, andAppstate: application.applicationState)
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Couldn't register: \(error)")
    }

}
