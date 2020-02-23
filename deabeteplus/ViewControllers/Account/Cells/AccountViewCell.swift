//
//  AccountViewCell.swift
//  deabeteplus
//
//  Created by pasin on 26/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class AccountViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ user: User) {
        titleLabel.text = user.name
        if let image = URL(string: user.image ?? "") {
            profileImageView.kf.setImage(with: image)
        } else {
            profileImageView.image = #imageLiteral(resourceName: "PROFILE3")
        }
//        subContentView.addShadow()
        
    }
    
//    var showInfoAction: (()->Void)?
    
//    @IBAction func showInfo() {
//        guard let action = showInfoAction else { return }
//        action()
//    }
    
}
