//
//  Navigator.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    
    var appNavigation: AppNavigation!
    
    static var shared: Navigator = {
        return Navigator(navigation: AppNavigation())
    }()
    
    init(navigation: AppNavigation) {
        self.appNavigation = navigation
    }

}

// 3 add navigate
extension Navigator {
    /// MARK : Push View
    func navigateToMoreView<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigateToMoreView() else { return }
        sender?.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigatorToLogin<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToLogin() else { return }
        sender?.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigatorToRegister<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToRegister() else { return }
        sender?.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigatorToAddProfile<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToAddProfile() else { return }
        sender?.navigationController?.pushViewController(view, animated: true)
    }
    
    func navigatorToFood<VC: UIViewController>(_ sender: VC?, food: Food) {
        guard let view = appNavigation.navigatorToFood() as? FoodViewController else { return }
        view.configure(food)
        sender?.navigationController?.pushViewController(view, animated: true)
    }
    
//    func navigatorToSendOTP<VC: UIViewController>(_ sender: VC?, profile: UserProfile, isSend: Bool = false) {
//        guard let view = appNavigation.navigatorToSendOTP() as? ConfirmOTPViewController else { return }
//        view.profile = profile
//        view.isSend = isSend
//        sender?.navigationController?.pushViewController(view, animated: true)
//    }
    
//    func navigatorUserProfile<VC: UIViewController>(_ sender: VC?, profile: UserProfile) {
//        guard let view = appNavigation.navigatorUserProfile() as? UserProfileViewController else { return }
//        view.configure(profile)
//        sender?.navigationController?.pushViewController(view, animated: true)
//    }
    
    func navigatorToProfileDetail<VC: UIViewController>(_ sender: VC?, user: User) {
        guard let view = appNavigation.navigatorToProfileDetail() as? ProfileDetailViewController else { return }
        view.configure(user)
        sender?.navigationController?.pushViewController(view, animated: true)
    }
}

extension Navigator {
    /// MARK : Pop View
    func showMoreView<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigateToMoreView() else { return }
        let nav = BaseNavigationViewController(rootViewController: view)
//        nav.title = "Nav"
//       nav.modalPresentationStyle = .fullScreen
        setNavbar(nav,sender)
        sender?.present(nav, animated: true)
    }
    
    func showImageView<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToImageView() else { return }
        view.modalPresentationStyle = .fullScreen
        sender?.present(view, animated: true)
    }
    
    func showLoginView<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToLogin() else { return }
        let nav = BaseNavigationViewController(rootViewController: view)
        nav.modalPresentationStyle = .fullScreen
        sender?.present(nav, animated: true)
    }
    
    func showSelectProfileView<VC: UIViewController>(_ sender: VC?, type: SelecProfileViewController.ViewType = .firstSelect) {
        guard let view = appNavigation.navigatorToSelectProfile() as? SelecProfileViewController else { return }
        view.configureView(type)
        let nav = BaseNavigationViewController(rootViewController: view)
        nav.modalPresentationStyle = .fullScreen
        sender?.present(nav, animated: true)
    }
    
    func showAccepTermVIew<VC: UIViewController>(_ sender: VC?) {
        guard let view = appNavigation.navigatorToTerm() else { return }
        let nav = BaseNavigationViewController(rootViewController: view)
        nav.modalPresentationStyle = .fullScreen
        sender?.present(nav, animated: true)
    }
    
//    func showSendOTP<VC: UIViewController>(_ sender: VC?, profile: UserProfile, isSend: Bool = false) {
//        guard let view = appNavigation.navigatorToSendOTP() as? ConfirmOTPViewController else { return }
//        view.profile = profile
//        view.isSend = isSend
//        let nav = BaseNavigationViewController(rootViewController: view)
//        nav.modalPresentationStyle = .fullScreen
//        sender?.present(nav, animated: true)
//    }
    
    // pass data
    func showFoodDetailView<VC: FoodDetailViewControllerDelegate & UIViewController>(_ sender: VC?, food: Food) {
        guard let view = appNavigation.navigatorToFoodDetail() as? FoodDetailViewController else {
            return
            
        }
        view.modalPresentationStyle = .overCurrentContext
        view.food = food
        view.delegate = sender
        sender?.present(view, animated: true)
    }
    

}

extension Navigator {
    private func setNavbar<VC: UIViewController>(_ nav: UINavigationController,_ sender: VC?) {
//        let item: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: sender, action: #selector(printHello))
//        let item: UIBarButtonItem = UIBarButtonItem(title: "hello", style: .plain, target: self, action: #selector(printHello))
//        nav.navigationItem.rightBarButtonItem = item
    }
    
    @objc private func printHello() {
        print("Hello")
    }
}
