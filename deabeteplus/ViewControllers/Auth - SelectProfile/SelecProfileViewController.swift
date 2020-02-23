//
//  SelecProfileViewController.swift
//  deabeteplus
//
//  Created by pasin on 11/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit
import Kingfisher

class SelecProfileViewController: UIViewController, BaseViewController {

    //MARK: ViewType
    enum ViewType: Int {
        case firstSelect = 0, selectFromAccount
    }
    
    
    //MARK: Properties
    @IBOutlet var profileImageView: [UIImageView]!
    @IBOutlet var nameLabel: [UILabel]!
    private var viewType: ViewType = .firstSelect
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar(title: "Select Profile" ,closeButton: viewType == .selectFromAccount)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
}

//MARK: Function
extension SelecProfileViewController {
    
    func configureView(_ type: ViewType) {
        viewType = type
    }
    
    @IBAction func doSelectProfile(_ sender: UIButton) {
        let tag = sender.tag
//        guard let user = UserManager.shared.currentUser, tag <= user.profiles.count else { return }
//        if tag == user.profiles.count {
//            // add profile
//            Navigator.shared.navigatorToAddProfile(self)
//        } else {
//            // select profile
//            if tag != 0 {
////                Navigator.shared.navigatorToSendOTP(self, profile: user.profiles[tag])
//                sendOTP(user.profiles[tag])
//                return
//            }
//
//            UserManager.shared.currentUser?.currentProfile = user.profiles[tag]
//            dismiss(animated: true)
//        }
    }
    
    func fetchUser() {
        // Change Profile From Account
        if let user = UserManager.shared.currentUser {
//            self.updateView(user)
            return
        }
        
        // First Select Profile
        guard let userId = UserManager.shared.userId else { return }
        // load user data
        UserViewModel().getProfile(userId, onSuccess: { [weak self] (user) in
            UserManager.shared.login(user)
//            self?.updateView(user)
        }) { [weak self] (_) in
            UserManager.shared.logut()
            self?.dismissView()
        }
        
        // set user profile

    }
    
//    func updateView(_ user: User) {
//
//        for index in 0..<4 {
//            let profileImageView = self.profileImageView[index]
//            let nameLabel = self.nameLabel[index]
//            if index >= user.profiles.count  {
//                nameLabel.isHidden = true
//                profileImageView.isHidden = !(user.profiles.count == index)
//            } else {
//                // have profile
//                let profile = user.profiles[index]
//                nameLabel.text = profile.name
//                nameLabel.isHidden = false
//                profileImageView.isHidden  = false
//                if let image = profile.image {
//                    profileImageView.kf.setImage(with: URL(string: image))
//                } else {
//                    profileImageView.image = UIImage(named: "PROFILE")
//                }
//            }
//        }
//    }
    
//    func sendOTP(_ profile: UserProfile) {
//        UserViewModel().sendOTP(profile.phone) { [weak self] (status) in
//            if !status {
//                self?.alert(title: "Error pls try agian")
//                return
//            }
//
//            Navigator.shared.navigatorToSendOTP(self, profile: profile, isSend: true)
//        }
//    }

}
