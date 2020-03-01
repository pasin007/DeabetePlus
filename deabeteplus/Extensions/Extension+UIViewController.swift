//
//  Extension+UIViewController.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.frame = view.frame
        child.didMove(toParent: self)
        view.addSubview(child.view)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        UIView.transition(with: self.view, duration: 0.25, options: [.curveEaseInOut], animations: {
            self.view.alpha = 0.0
        }) { (fn) in
            self.view.removeFromSuperview()
        }
    }
}

extension UIViewController {
    func showLogutAction() {
        let alert: UIAlertController = UIAlertController(title: "Sure ?", message: nil, preferredStyle: .actionSheet)
        let logout: UIAlertAction = UIAlertAction(title: "Logout", style: .cancel) { [weak self] (_) in
            UserManager.shared.logut()
            self?.tabBarController?.selectedIndex = 0
        }
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(logout)
        
        present(alert, animated: true)
    }
    
    @objc func dismissView(_ animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: animated)
        }
    }
    
    var closeBarButton: UIBarButtonItem {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "close-b") , style: .plain, target: self, action: #selector(dismissView))
    }
    
    func configureNavbar(title: String, closeButton: Bool = false, hidesBackButton: Bool = false) {

        self.title = title
        
        // Title Text Attributes
        navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.font : UIFont(name: "Ride", size: 18)!,
            NSAttributedString.Key.foregroundColor : UIColor("#CCCCCC")
        ]

//        navigationController?.removeNavBarBottomLine()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "      ", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.tintColor = .black
        
        if closeButton {
          navigationItem.rightBarButtonItem = closeBarButton
        }
        navigationItem.hidesBackButton = hidesBackButton
    }
    
    func alert(title: String = "", message: String = "", titleButton: String = "OK", completionButton: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil ) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: titleButton, style: .default, handler: completionButton)
        alert.addAction(action)
        present(alert, animated: true, completion: completion)
    }
}


import NVActivityIndicatorView
class Loading: LoadingProtocol  {
    static func stopLoading(_ sender: (UIViewController & NVActivityIndicatorViewable)?) {
        guard let sender = sender else { return }
        sender.stopAnimating()
    }
    
    static func startLoading(_ sender: (UIViewController & NVActivityIndicatorViewable)?) {
        guard let sender = sender else { return }
        let font = UIFont(name: "Kodchasan-Bold", size: 18)
        let type: NVActivityIndicatorType = .ballPulse
        let color: UIColor = .blue
        let backgroundColor: UIColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
                             
        sender.startAnimating(nil, message: nil, messageFont: font, type: type, color: color, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: backgroundColor, textColor: .white, fadeInAnimation: nil)
    }
    
}

protocol LoadingProtocol: NVActivityIndicatorViewable {
    static func startLoading(_ sender: (UIViewController & NVActivityIndicatorViewable)?)
    static func stopLoading(_ sender: (UIViewController & NVActivityIndicatorViewable)?)
}
