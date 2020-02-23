//
//  SelectImageViewCell.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class SelectImageViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var selectAction: (()->Void)?
    @IBAction func doSelectImage() {
        guard let action = selectAction else { return }
        action()
    }
}
