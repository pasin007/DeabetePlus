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

    func configure( cal: Int, carb: Int) {
        
        let carbText = carb < 0 ? "เกิน \(carb * -1) Carb" : "\(carb) Carb"
        let calText = cal < 0 ? "เกิน \(cal * -1) Kcal" : "\(cal) Kcal"
        calLabel.text = "\(carbText) \n \(calText)"
        calLabel.textColor = .white
        
        if let font = UIFont(name: "Kodchasan-Bold", size: 20){
            calLabel.font = font
        }
            //Kodchasan-Bold
        
        profileImage.cornerRadius = profileImage.frame.width / 2
        guard let user = UserManager.shared.currentUser else { return }
        if let imageString = user.image, let imageUrl = URL(string: imageString) {
            profileImage.kf.setImage(with: imageUrl)
        }
    }
}
