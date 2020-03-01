//
//  LoginViewController.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit
import MaterialTextField

class LoginViewController: UIViewController, BaseViewController {

    @IBOutlet weak var phoneTextfield: MFTextField!
    
    private var viewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        

        // Do any additional setup after loading the view.
    }


}

extension LoginViewController {
    @IBAction func doLogin() {
        guard let phone = phoneTextfield.text,
            !phone.trim.isEmpty else { return }
        
//        let parms: [String:Any] = [
//            "phone": phone,
//        ]
        
        Loading.startLoading(self)
//        viewModel.login(parms, onSuccess: { [weak self] user in
//            Loading.stopLoading(self)
//            UserManager.shared.login(user)
//            self?.dismiss(animated: true)
//        }, onError: { error in
//            Loading.stopLoading(self)
//        })
        
        viewModel.sendOTP(phone) { [weak self] (status) in
            Loading.stopLoading(self)
            guard status else {
                self?.alert(title: "error")
                return
            }
            Navigator.shared.navigatorToSendOTP(self)
        }
    }
    
    @IBAction func navigatorToRegister() {
        Navigator.shared.navigatorToRegister(self)
    }
}
