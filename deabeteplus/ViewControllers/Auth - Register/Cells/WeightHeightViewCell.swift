//
//  WeightHeightViewCell.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit
import MaterialTextField

class WeightHeightViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var weightTextField: MFTextField!
    @IBOutlet weak var heightTextField: MFTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weightTextField.delegate = self
        heightTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var textFieldAction: (((String?,String?))->Void)?
    
}
extension WeightHeightViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let action = textFieldAction else { return }
        let value = (weightTextField.text,heightTextField.text)
        action(value)
        
    }
}
