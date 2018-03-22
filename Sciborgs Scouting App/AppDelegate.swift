//
//  AppDelegate.swift
//  Sciborgs Scouting App
//
//  Created by Alexander Warren on 11/1/17.
//  Copyright © 2017 Alexander Warren. All rights reserved.
//

import UIKit
import CoreData
//import Firebase
import GoogleSignIn
import GoogleAPIClientForREST
//import FirebaseAuth

//#import <GTMSessionFetcher/GTMSessionFetcher.h>
//#import <GTMSessionFetcher/GTMSessionFetcherService.h>


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    let testEmail = "test987898789@gmail.com"
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if (error) != nil {
            print(error)
            return
        }
        
        print(user.profile.name)

        
        guard let authentication = user.authentication else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
        SignInViewController.instance.present(vc, animated: true, completion: {})

        print(user.serverAuthCode)
        print(user.authentication.accessToken)
        CurrentUser.user = user
        
        
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signIn(with: credential, completion: { (user, error) in
//            if error != nil{
//                return
//            }
//
//            if(user?.email!.split(separator: "@")[1] == "bxscience.edu" || user?.email! == self.testEmail){
//                print("yes")
//                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
//                SignInViewController.instance.present(vc, animated: true, completion: {})
//            }else{
//                print("no")
//            }
//
//
//        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //GIDSignIn.sharedInstance().signOut()
        // Override point for customization after application launch.
//        FirebaseApp.configure()
//
//        let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
//        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
//            let myDict = NSDictionary(contentsOfFile: path)!
//            GIDSignIn.sharedInstance().clientID = myDict["CLIENT_ID"]! as! String
//            print(myDict["CLIENT_ID"]!)
//        }
        GIDSignIn.sharedInstance().clientID = "372162650684-q2hnnedp8qpm74vabcm68jdqiih9htoo.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().serverClientID = "372162650684-q2hnnedp8qpm74vabcm68jdqiih9htoo.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeSheetsSpreadsheets]
//        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeSheetsSpreadsheets]

        GIDSignIn.sharedInstance().delegate = self
        print(GIDSignIn.sharedInstance().hasAuthInKeychain())
        
//        GIDSignIn.sharedInstance().scopes = scopes
       GIDSignIn.sharedInstance().signInSilently()

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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Sciborgs_Scouting_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }

}
