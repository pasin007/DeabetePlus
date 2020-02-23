//
//  AppNavigation.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

// 1 add protocol
protocol Navigation: class {
    func navigateToMoreView() -> UIViewController?
    func navigateToHomeView() -> UIViewController?
    func navigatorToImageView() -> UIViewController?
    func navigatorToScan() -> UIViewController?
    
    // Auth
    func navigatorToLogin() -> UIViewController?
    func navigatorToRegister() -> UIViewController?
    func navigatorToSelectProfile() -> UIViewController?
    func navigatorToAddProfile() -> UIViewController?
    
    func navigatorToAccount() -> UIViewController?
    func navigatorToProfileDetail() -> UIViewController?
    
    func navigatorToFoodDetail() -> UIViewController?
    func navigatorToFood() -> UIViewController?
    
    
    func navigatorToTerm() -> UIViewController?
    func navigatorToSendOTP() -> UIViewController?
    func navigatorUserProfile() -> UIViewController?
    func navigatorChat() -> UIViewController?
    func navigatorMedic() -> UIViewController?
}

// 2 add func
class AppNavigation: Navigation {
    func navigatorToProfileDetail() -> UIViewController? {
        return ProfileDetailViewController.instance
    }
    
    func navigatorToImageView() -> UIViewController? {
        return ImageViewController.instance
    }
    
    func navigateToHomeView() -> UIViewController? {
        return HomeViewController.instance
    }
    
    func navigateToMoreView() -> UIViewController? {
        return MoreViewController.instance
    }
    
    func navigatorToScan() -> UIViewController? {
        return ScanViewController.instance
    }
    
    func navigatorToLogin() -> UIViewController? {
        return LoginViewController.instance
    }
    
    func navigatorToRegister() -> UIViewController? {
        return RegisterViewController.instance
    }
    
    func navigatorToSelectProfile() -> UIViewController? {
        return SelecProfileViewController.instance
    }
    
    func navigatorToAddProfile() -> UIViewController? {
        return AddProfileViewController.instance
    }
    
    func navigatorToAccount() -> UIViewController? {
        return AccountViewController.instance
    }
    
    func navigatorToFoodDetail() -> UIViewController? {
        return FoodDetailViewController.instance
    }
    
    func navigatorToFood() -> UIViewController? {
        return FoodViewController.instance
    }
    
    func navigatorToTerm() -> UIViewController? {
        return AccepTermViewController.instance
    }
    
    func navigatorToSendOTP() -> UIViewController? {
        return ConfirmOTPViewController.instance
    }
    
    func navigatorUserProfile() -> UIViewController? {
        return UserProfileViewController.instance
    }
    
    func navigatorChat() -> UIViewController? {
           return ChatViewController.instance
       }
    func navigatorMedic() -> UIViewController? {
        return MedicViewController.instance
    }
}
