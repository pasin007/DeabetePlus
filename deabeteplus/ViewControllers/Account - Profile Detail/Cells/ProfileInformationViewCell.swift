//
//  ProfileInformationViewCell.swift
//  deabeteplus
//
//  Created by pasin on 9/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class ProfileInformationViewCell: UITableViewCell, BaseViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData() {
        guard let user = UserManager.shared.currentUser else { return }
       
        let date = user.birthdate.toDate(withFormat: "yyyy-mm-dd")
        configure(date?.toString("dd/mm/yyyy") ?? user.birthdate, gender: user.gender, weight: user.weight, height: user.height)
    }
    
    func configure(_ date: String, gender: String, weight: Double, height: Double) {
        dateLabel.text = "ว/ด/ป เกิด \(date)"
        genderLabel.text = "เพศ \(gender)"
        weightLabel.text = "น้ำหนัก \(weight) ก.ก."
        heightLabel.text = "ส่วนสูง \(height) ซ.ม."
        
    }
}
