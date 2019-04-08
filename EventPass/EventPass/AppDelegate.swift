//
//  AppDelegate.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 3/29/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UINavigationBar.appearance().tintColor = .highlightYellow
        UINavigationBar.appearance().barTintColor = .baseBlue
        UINavigationBar.appearance().isOpaque = true
        
        let navigationController = UINavigationController(rootViewController: self.initialTabBarController())
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

    func initialTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.barTintColor = .baseBlue
        tabBarController.tabBar.backgroundColor = .baseBlue
        tabBarController.tabBar.unselectedItemTintColor = .white
        tabBarController.tabBar.tintColor = .highlightYellow
        
        let eventsViewController = EventsViewController()
        let eventsNavigationController = UINavigationController(
            rootViewController: eventsViewController
        )
        
        let ticketsViewController = TicketsViewController()
        let ticketsNavigationController = UINavigationController(
            rootViewController: ticketsViewController
        )
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(
            rootViewController: profileViewController
        )
        
        let tabBarControllers = [eventsNavigationController,
                                 ticketsNavigationController,
                                 profileNavigationController]
        
        let eventsImage = UIImage(named: "star")!
        eventsNavigationController.tabBarItem.image = eventsImage
            .withRenderingMode(.alwaysTemplate)
        eventsNavigationController.tabBarItem.title = "Eventos"
        
        let ticketsImage = UIImage(named: "ticket")!
        ticketsNavigationController.tabBarItem.image = ticketsImage
            .withRenderingMode(.alwaysTemplate)
        ticketsNavigationController.tabBarItem.title = "Ingressos"
        
        let profileImage = UIImage(named: "user")!
        profileNavigationController.tabBarItem.image = profileImage
            .withRenderingMode(.alwaysTemplate)
        profileNavigationController.tabBarItem.title = "Perfil"
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        tabBarController.navigationItem.titleView = imageView
        tabBarController.setViewControllers(tabBarControllers, animated: false)
        tabBarController.selectedViewController = eventsNavigationController
        
        return tabBarController
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

