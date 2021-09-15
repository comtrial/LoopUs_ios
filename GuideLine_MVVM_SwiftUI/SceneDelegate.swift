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
            tabBarController.setViewControllers([ homeVC, searchVC, uploadVC, notificationVC, personalVC], animated: true)
            //tabBarController.tabBar.isHidden = false

            
            let loginViewModel = LoginSignupViewModel()
            let loginContentView = LoginContentView(viewModel:loginViewModel)
            let loginVC = LoginViewController(rootView: loginContentView)
            
            if loginViewModel.isLogged {
                window.rootViewController = tabBarController
            }
            else {window.rootViewController = loginVC}
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
   
    
    //Home
    func homeViewController() -> UIViewController {
        let homeViewModel = HomeViewModel()
        let homeContentView = HomeContentView(feedModel: homeViewModel)
        let homeVC = HomeViewController(rootView: homeContentView)
        homeVC.title = "Home"
        
        let navController = UINavigationController(rootViewController: homeVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
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
        navController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return navController
    }
    
    //Search
    func uploadViewController() -> UIViewController {
        
        let uploadContentView = UploadContentView()
        let uploadVC = UploadViewController(rootView: uploadContentView)
        uploadVC.title = "Upload"
        
        let navController = UINavigationController(rootViewController: uploadVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "square.and.arrow.up"), tag: 3)
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
        navController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell.badge.fill"), tag: 4)
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
        navController.tabBarItem = UITabBarItem(title: "personalVC", image: UIImage(systemName: "person.circle.fill"), tag: 5)
        return navController
    }
}

