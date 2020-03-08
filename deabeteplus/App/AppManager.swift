//
//  AppManager.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit
import Foundation

class AppManager: NSObject {
    static let shared = AppManager()
    
    private var tabCount: Int = 0
    private var allowSelectedTab: Bool = true
    private weak var previousVC: UIViewController?
    
    var isAcceptTerm: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: KeyManager.keyTerm)
        }
        
        get {
            guard let isAcceptTerm =  UserDefaults.standard.value(forKey: KeyManager.keyTerm) as? Bool else { return false }
            return isAcceptTerm
        }
    }

    enum TabBarType: Int {
        case home = 0, more
    }

    func tabBar() -> UITabBarController {
        let tabBarView = UITabBarController()
        let viewControllers: [UIViewController]? = [
            // TODO:- Add viewcontrollers here
            homeView(),
            homeView()
        ]

        tabBarView.viewControllers = viewControllers
        tabBarView.tabBar.isTranslucent = false
        tabBarView.view.backgroundColor = .white
        tabBarView.delegate = self
        
        return tabBarView
    }

    func initApp() -> UIViewController {
        return embededInNavigationController(HomeViewController.instance)
    }

    deinit {
        previousVC = nil
    }
    
}

extension AppManager {
    ///  1: -Tab bar menu
    ///  2: -Add item at BaseTabBarViewController
     func homeView() -> UIViewController {
        let view = HomeViewController.instance
        view.tabBarItem = UITabBarItem(title: " ", image: #imageLiteral(resourceName: "Vector 1"), tag: TabBarType.home.rawValue)
        view.hidesBottomBarWhenPushed = false
        view.title = "Home"
        view.tabBarController?.tabBar.barTintColor = UIColor(hexString: "#BEDB86")
        return embededInNavigationController(view)
    }

    func moreView() -> UIViewController {
//        #imageLiteral(resourceName: "camera")
//        UIImage(named: "camera")
        let view = ScanViewController.instance
        view.tabBarItem = UITabBarItem(title: "SCAN", image: #imageLiteral(resourceName: "Group 2-1"), tag: TabBarType.more.rawValue)
        view.hidesBottomBarWhenPushed = false
        view.title = "Scan"
//        return embededInNavigationController(view)
        return view
    }
    
    func chatView() -> UIViewController {
        let view = ChatViewController.instance
        view.tabBarItem = UITabBarItem(title: "Chat", image: #imageLiteral(resourceName: "Exclude-2"), tag: TabBarType.more.rawValue)
        view.hidesBottomBarWhenPushed = false
        view.title = "Chat"
        return embededInNavigationController(view)
    }
    func medicView() -> UIViewController {
           let view = MedicViewController.instance
           view.tabBarItem = UITabBarItem(title: "Medic", image: #imageLiteral(resourceName: "Exclude-1"), tag: TabBarType.more.rawValue)
           view.hidesBottomBarWhenPushed = false
           view.title = "Medic"
           return embededInNavigationController(view)
       }
    func accountView() -> UIViewController {
        let view = AccountViewController.instance
        view.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "Vector 5"), tag: TabBarType.more.rawValue)
        view.hidesBottomBarWhenPushed = false
        view.title = "Account"
        return embededInNavigationController(view)
    }
}

extension AppManager {
    private func embededInNavigationController(_ view: UIViewController) -> UIViewController {
        return BaseNavigationViewController(rootViewController: view)
    }
}

extension AppManager {
    var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    var bundleId: String {
        return Bundle.main.bundleIdentifier ?? "pasin.com.deabeteplus"
    }
}

// MARK:- Tab bar delegate
extension AppManager: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return allowSelectedTab
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if previousVC?.tabBarItem.tag == viewController.tabBarItem.tag {
            tabCount += 1
        }

        viewController.navigationController?.popToRootViewController(animated: true)
        previousVC = viewController
    }
}
