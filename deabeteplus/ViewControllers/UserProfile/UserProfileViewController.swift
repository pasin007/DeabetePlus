//
//  UserProfileViewController.swift
//  deabeteplus
//
//  Created by pasin on 29/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, BaseViewController {
    
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
//    private var profile: UserProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
        // Do any additional setup after loading the view.
    }




}

extension UserProfileViewController {
//    func configure(_ profile: UserProfile) {
//        self.profile = profile
//    }
    
    func setupView() {
//        guard let user = UserManager.shared.currentUser, profile.id == user.profiles.first?.id else { return }
////        user.name
//        bmiLabel.text = "bmi : \(user.bmis[0].bmi)"
//        calLabel.text = "cal : \(user.today_eat)"
//        weightLabel.text = "weight : \(user.bmis[0].weight)"
//        heightLabel.text = "height : \(user.bmis[0].height)"
//
//        nameLabel.text = user.name
//
//        print("profile")
//
    }
}
