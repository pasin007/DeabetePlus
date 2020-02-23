//
//  SearchTextfieldViewCell.swift
//  deabeteplus
//
//  Created by pasin on 9/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class SearchTextfieldViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    var textFieldAction: ((String?) -> Void)?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension SearchTextfieldViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let action = textFieldAction else { return }
        action(textField.text)
    }
}
