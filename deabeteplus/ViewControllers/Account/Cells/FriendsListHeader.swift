//
//  FriendsListHeader.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class FriendsListHeader: UITableViewHeaderFooterView, BaseViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    var addAction: (()->Void)?
    
    @IBAction func doAddFriend() {
        guard let action = addAction else { return }
        action()
    }

}
