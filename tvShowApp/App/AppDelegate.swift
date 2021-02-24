//
//  AppDelegate.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
            
            print("url \(url)")
            print("url host :\(url.host!)")
            print("url path :\(url.path)")
            
            
        let urlPath : String = url.path as String? ?? ""
        let urlHost : String = url.host as String? ?? ""
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            if(urlHost != "swiftdeveloperblog.com")
            {
                print("Host is not correct")
                return false
            }
            
            if(urlPath == "/inner"){
                
                let innerPage: CollectionViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeII") as! CollectionViewController
                self.window?.rootViewController = innerPage
            } else if (urlPath == "/about"){
                
            }
            self.window?.makeKeyAndVisible()
            return true
        }


}

