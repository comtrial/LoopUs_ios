//
//  SceneDelegate.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let homeVC = homeViewController()
            let searchVC = searchViewController()
            let uploadVC = uploadViewController()
            let notificationVC = notificationViewController()
            let personalVC = personalViewController()
            
            
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([homeVC, searchVC, uploadVC, notificationVC, personalVC], animated: false)
            //tabBarController.tabBar.isHidden = false
            window.rootViewController = tabBarController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    //Home
    func homeViewController() -> UIViewController {
        let homeViewModel = HomeViewModel()
        let homeContentView = HomeContentView(userModel: homeViewModel)
        let homeVC = HomeViewController(rootView: homeContentView)
        homeVC.title = "Home"
        
        let navController = UINavigationController(rootViewController: homeVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
//        navController.setToolbarHidden(<#T##hidden: Bool##Bool#>, animated: <#T##Bool#>)
//        navController.setToolbarHidden(true, animated: false)
//        DispatchQueue.main.async {
//            navController.isNavigationBarHidden = true
//                }
        //navController.setNavigationBarHidden(true, animated: false)
        return navController
    }
    
    //Search
    func searchViewController() -> UIViewController {
        
        let searchContentView = SearchContentView()
        let searchVC = SearchViewController(rootView: searchContentView)
        searchVC.title = "Search"
        
        let navController = UINavigationController(rootViewController: searchVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return navController
    }
    
    //Search
    func uploadViewController() -> UIViewController {
        
        let uploadContentView = UploadContentView()
        let uploadVC = UploadViewController(rootView: uploadContentView)
        uploadVC.title = "Upload"
        
        let navController = UINavigationController(rootViewController: uploadVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "square.and.arrow.up"), tag: 2)
        return navController
    }
    
    //Notification
    func notificationViewController() -> UIViewController {
        let notificationViewModel = NotificationViewModel()
        let notificationContentView = NotificationContentView()
        let notificationVC = NotificationViewController(rootView: notificationContentView)
        notificationVC.title = "Notification"

        let navController = UINavigationController(rootViewController: notificationVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell.badge.fill"), tag: 3)
        return navController
    }
    
    //Personal
    func personalViewController() -> UIViewController {
        let personalViewModel = PersonalViewModel()
        let personalContentView = PersonalContentView()
        let personalVC = PersonalViewController(rootView: personalContentView)
        personalVC.title = "Personal"

        let navController = UINavigationController(rootViewController: personalVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "personalVC", image: UIImage(systemName: "person.circle.fill"), tag: 4)
        return navController
    }
}

