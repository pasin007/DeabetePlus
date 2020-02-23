//
//  RegisterButtonViewCell.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class RegisterButtonViewCell: UITableViewCell, BaseViewCell {
    
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var buttonAction:(()->Void)?
    
    @IBAction func clickAction() {
        guard let action = buttonAction else { return }
        action()
    }
}
