//
//  Extension+AppDelegate.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//


import UIKit
import Firebase


/// MARK : configure App
extension SceneDelegate {
    
    func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = AppManager.shared.tabBar()
        window?.makeKeyAndVisible()
    }

    func currentController() -> UIViewController {
        var currentController: UIViewController = window!.rootViewController!
        while (currentController.presentedViewController != nil) {
            currentController = currentController.presentedViewController!
        }
        return currentController
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func bootstrapFirebase() {
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        guard let opts = FirebaseOptions(contentsOfFile: filePath!) else {
            print("Couldn't load config file")
            return
        }
        FirebaseApp.configure(options: opts)
    }

}

/// MARK: Auth
extension SceneDelegate {
    
    func checkUserLogin() {
        guard let userId = UserManager.shared.userId else {
            // not login
            window?.makeKeyAndVisible()
            Navigator.shared.showLoginView(window?.rootViewController)
            return
        }
        // login
//        guard UserManager.shared.currentUser != nil else { return }
        UserViewModel().getProfile(userId, onSuccess: { (user) in
            UserManager.shared.login(user)
        }) { (_) in

        }

    }
}


extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
