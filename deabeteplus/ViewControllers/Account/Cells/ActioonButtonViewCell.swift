//
//  ActioonButtonViewCell.swift
//  deabeteplus
//
//  Created by pasin on 26/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class ActioonButtonViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var buttonAction: (()->Void)?
    
    @IBAction func clickButton() {
        guard let action = buttonAction else { return }
        action()
    }
}
