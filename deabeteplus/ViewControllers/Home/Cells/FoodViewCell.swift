//
//  FoodViewCell.swift
//  deabeteplus
//
//  Created by pasin on 19/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class FoodViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var subContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subContentView.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FoodViewCell {
    func configure(_ food: Food) {
        titleLabel.text = food.name
        detailLabel.text = "ให้พลังงาน \(Int(food.kcal)) Kcal / จาน"
        if let imageUrl = URL(string: food.imageUrl) {
            foodImage.kf.setImage(with: imageUrl)
        }
    }
}
