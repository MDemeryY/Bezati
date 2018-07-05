//
//  AppDelegate.swift
//  ManageMoney
//
//  Created by admin101 on 4/2/18.
//  Copyright © 2018 demi. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Localizer.DoTheExchange()
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBHandler()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge , .sound]) { (success, error) in
            
            if error == nil {
                print("successfully authorization")
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector (self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ManageMoney")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    @objc func refreshToken(notification:NSNotification){
        let refreshToken = InstanceID.instanceID().token()
        print("notififcation token \(refreshToken ?? "")")
    }
    
    func FBHandler(){
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
}

