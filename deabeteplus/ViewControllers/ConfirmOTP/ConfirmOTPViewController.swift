//
//  ConfirmOTPViewController.swift
//  deabeteplus
//
//  Created by pasin on 28/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class ConfirmOTPViewController: UIViewController, BaseViewController {

    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var otpButton: UIButton!
    
    var isSend: Bool = true
//    var profile: UserProfile!
    private var viewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let profile = profile {
//            sendOTP(profile.phone)
//            otpButton.setTitle("ส่ง  otp", for: .normal)
//        }
//        if isSend {
//            updateView()
        alert(title: "OTP had been send")
        otpTextField.text = nil
        otpTextField.placeholder = "OTP"
        otpLabel.text = "Verification Number"
//        }
        // Do any additional setup after loading the view.
    }


    @IBAction func doSend(_ sender: UIButton) {
        if !isSend {
            sendOTP(sender)
        } else {
            doCheckOTP(sender)
        }
    }
    
    func updateView() {
        if isSend {
            otpTextField.text = nil
            otpTextField.placeholder = "OTP"
            otpLabel.text = "Verification Number"
        } else {
            otpTextField.text = nil
            otpTextField.placeholder = "Phone number"
            otpLabel.text = "Phone"
        }
    }

    
    func sendOTP(_ sender: UIButton) {
        guard let phone = otpTextField.text else { return }
        viewModel.sendOTP(phone) { [weak self] (status) in
            if !status {
                self?.alert(title: "Error pls try agian")
                return
            }
            
            self?.alert(title: "OTP had been send")
            self?.isSend = true
            sender.setTitle("ส่ง otp ", for: .normal)
//            self?.updateView()
        }
    }
    
    func sendOTP(_ phone: String) {
        viewModel.sendOTP(phone) { [weak self] (status) in
            if !status {
                self?.alert(title: "Error pls try agian")
                return
            }
            
            self?.alert(title: "OTP had been send")
            self?.isSend = true
            self?.updateView()
        }
    }
    
    func doCheckOTP(_ sender: UIButton) {
        guard let otp = otpTextField.text else { return }
        Loading.startLoading(self)
        viewModel.checkOTP(otp) { [weak self] (user) in
            Loading.stopLoading(self)
            guard let user = user else { return }
            UserManager.shared.login(user)
            self?.dismissView()
//            if !status {
//                self?.alert(title: "Error pls try agian")
//                return
//            }
            
//            if let profile = self?.profile {
//                UserManager.shared.currentUser?.currentProfile = profile
//                self?.dismissView()
//            }
        }
    }
}
