//
//  HomeHeaderViewCell.swift
//  deabeteplus
//
//  Created by pasin on 19/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class HomeHeaderViewCell: UITableViewHeaderFooterView, BaseViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var calLabel: UILabel!
//    if let font = UIFont(name: "Kodchasan-SemiBold", size: 18) {
//        cell.textLabel?.font = font
//    }

    func configure(_ cal: String) {
        if let calInt = Int(cal) {
            let calText = calInt < 0 ? "เกิน \(calInt * -1) Kcal" : "\(cal) Kcal"
            calLabel.text = calText
            calLabel.textColor = .white
            if let font = UIFont(name: "Kodchasan-Bold", size: 24){
                calLabel.font = font
            }
            //Kodchasan-Bold
        }
        profileImage.cornerRadius = profileImage.frame.width / 2
//        guard let currentProfile = UserManager.shared.currentUser?.currentProfile else { return }
//        if let imageString = currentProfile.image, let imageUrl = URL(string: imageString) {
//            profileImage.kf.setImage(with: imageUrl)
//        }
    }
}
