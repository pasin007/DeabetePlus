//
//  RegisterViewController.swift
//  deabeteplus
//
//  Created by pasin on 23/2/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

// MARK: - Form
class RegisterForm {
    var name: String?
    var gender: String?
    var birthdate: String?
    var mobile: String?
    var image: String?
    var weight: String?
    var height: String?
    
    var parameters: [String:Any] {
        var parameters = [String:Any]()
        parameters["name"] = (name ?? "") + " "
        parameters["phone"] = mobile
        parameters["weight"] = weight
        parameters["height"] = height
        parameters["gender"] = gender
        
        if let date = birthdate?.toDate(withFormat: "dd MMMM yyyy") {
            let birthdate = date.toString("yyyy-MM-dd")
            parameters["birthdate"] = birthdate
        }
        return parameters
    }
}

class RegisterViewController: UIViewController, BaseViewController {
    
    // MARK: - Types
    enum RegisterCells: Int, CaseIterable {
        case image = 0, mobile, name, gender, birthdate, weightHeight, submitButton
        
        var placeholder: String {
            switch self {
            case .mobile: return "เบอร์ติดต่อ"
            case .name: return "ชื่อ"
            case .gender: return "เพศ"
            case .birthdate: return "วันเดือนปีเกิด"
            default: return ""
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    // MARK: - Properties
    private var form: RegisterForm = RegisterForm()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func doSubmit() {
        debugPrint(form.parameters)
    }

}

extension RegisterViewController {
    private func configureTableView() {
        tableView.dataSource = self
        
        tableView.register(SelectImageViewCell.nib, forCellReuseIdentifier: SelectImageViewCell.identifier)
        tableView.register(RegisterFieldViewCell.nib, forCellReuseIdentifier: RegisterFieldViewCell.identifier)
        tableView.register(WeightHeightViewCell.nib, forCellReuseIdentifier: WeightHeightViewCell.identifier)
        tableView.register(RegisterButtonViewCell.nib, forCellReuseIdentifier: RegisterButtonViewCell.identifier)
    }
}

extension RegisterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RegisterCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowCell = RegisterCells(rawValue: indexPath.row) else { return UITableViewCell() }
        switch rowCell {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectImageViewCell.identifier, for: indexPath) as! SelectImageViewCell
            return cell
        case .mobile:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterFieldViewCell.identifier, for: indexPath) as! RegisterFieldViewCell
            cell.configure(rowCell, value: form.mobile)
            cell.textFieldAction = { [weak form] (value) in
                form?.mobile = value
            }
            return cell
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterFieldViewCell.identifier, for: indexPath) as! RegisterFieldViewCell
            cell.configure(rowCell, value: form.name)
            cell.textFieldAction = { [weak form] (value) in
                form?.name = value
            }
            return cell
        case .gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterFieldViewCell.identifier, for: indexPath) as! RegisterFieldViewCell
            cell.configure(rowCell, value: form.gender, delegate: self)
            cell.textFieldAction = { [weak form] (value) in
                form?.gender = value
            }
            return cell
        case .birthdate:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterFieldViewCell.identifier, for: indexPath) as! RegisterFieldViewCell
            cell.configure(rowCell, value: form.birthdate, delegate: self)
            cell.textFieldAction = { [weak form] (value) in
                form?.birthdate = value
            }
            return cell
        case .weightHeight:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeightHeightViewCell.identifier, for: indexPath) as! WeightHeightViewCell
            cell.textFieldAction = { [weak form] (value) in
                form?.weight = value.0
                form?.height = value.1
            }
            return cell
        case .submitButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterButtonViewCell.identifier, for: indexPath) as! RegisterButtonViewCell
            cell.buttonAction = doSubmit
            return cell
        }
    }
    
}
