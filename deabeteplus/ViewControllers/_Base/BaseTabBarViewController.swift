//
//  BaseTabBarViewController.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BaseTabBarViewController: UITabBarControllerDelegate {
  
    private func configure() {
        let viewControllers: [UIViewController]? = [
            // TODO:- Add viewcontrollers here
            AppManager.shared.homeView(),
            AppManager.shared.medicView(),
            AppManager.shared.moreView(),
            AppManager.shared.chatView(),
            AppManager.shared.accountView()
            
        ]
        
        self.viewControllers = viewControllers
        tabBar.isTranslucent = false
        delegate = self
        view.backgroundColor = .white
    }
}
