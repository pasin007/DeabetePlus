//
//  RegisterFieldViewCell.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit
import MaterialTextField

class RegisterFieldViewCell: UITableViewCell, BaseViewCell {
    
    enum Gender: Int, CaseIterable {
        case male = 0, female
        
        var title: String {
            switch self {
            case .male:
                return "ชาย"
            case .female:
                return "หญิง"
            }
        }
    }
    
    
    @IBOutlet weak var textField: MFTextField!
    @IBOutlet weak var dropDownButton: UIButton!
    
    private var pickerGender: UIPickerView = UIPickerView()
    private var pickerDate: UIDatePicker = UIDatePicker()
    private var delegate: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ type: RegisterViewController.RegisterCells, value: String?, delegate: UIViewController? = nil) {
        textField.placeholder = type.placeholder
        textField.text = value
        let isDropDown = type == .gender || type == .birthdate
        dropDownButton.isHidden = !isDropDown
        
        switch type {
        case .gender:
            createGenderPicker()
        case .birthdate:
            createDatePicker()
        default:
            break
        }
        self.delegate = delegate
    }
    
    var textFieldAction: ((String?)->Void)?
}

/// MARK: Date Picker
extension RegisterFieldViewCell {
    func createDatePicker() {
        // 1 - configure Date Picker
        pickerDate.datePickerMode = .date
        pickerDate.calendar = Calendar(identifier: .buddhist)
        pickerDate.locale = Locale(identifier: "th")
        
        // 2 - create tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 3 - add toolbar action
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.showdate))
        toolbar.setItems([done], animated: false)
        
        // 4 - set inputView
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerDate
    }
    
    @objc func showdate(){
//        print("date : \(pickerDate.date)")
        
        // 5 - create formatter to text field
        let dateformate = DateFormatter()
        dateformate.locale = Locale(identifier: "th")
        dateformate.dateFormat = "dd MMMM yyyy"
        
        // 6 - formatter date
        let string = dateformate.string(from: pickerDate.date)
        textField.text = string
        
        
          // 5 - create formatter to database
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        formater.locale = Locale(identifier: "th")
        
//        birthdate = formater.string(from: pickerDate.date)
        
        
        delegate?.view.endEditing(true)
    }
}

extension RegisterFieldViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gender = Gender(rawValue: row) else { return }
        textField.text = gender.title
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /// row
        guard let gender = Gender(rawValue: row) else { return nil }
        return gender.title
    }
    
    func createGenderPicker() {
        // set delegate & dataSource
        pickerGender.delegate = self
        pickerGender.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.done))
        toolbar.setItems([done], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerGender
    }
    
    @objc func done() {
        if textField.text == "" {
            textField.text = Gender.male.title
        }
        delegate?.view.endEditing(true)
    }
    
}

extension RegisterFieldViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let action = textFieldAction else { return }
        action(textField.text)
    }
}
