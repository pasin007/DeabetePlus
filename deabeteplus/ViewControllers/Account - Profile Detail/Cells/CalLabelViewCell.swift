//
//  CalLabelViewCell.swift
//  deabeteplus
//
//  Created by pasin on 9/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class CalLabelViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var subValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ type: ChartViewCell.ChartType, value: String) {
        titleLabel.text = type.title
        valueLabel.text = value
        subValueLabel.text = type.subValue
    }
    
}
