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
    var profileImage: UIImage?
    var profileImageUrl: String?
    
    var parameters: [String:Any] {
        var parameters = [String:Any]()
        parameters["name"] = (name ?? "") + " "
        parameters["phone"] = mobile
        parameters["weight"] = weight
        parameters["height"] = height
        parameters["gender"] = gender
        parameters["image"] = profileImageUrl
        
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
    private let viewModel: UserViewModel = UserViewModel()
    private let imageViewModel: ImageViewModel = ImageViewModel()
    private var picker: UIImagePickerController = UIImagePickerController()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func doSubmit() {
        debugPrint(form.parameters)
        Loading.startLoading(self)
        guard let image = form.profileImage else {
            doRegiser()
            return
        }
        imageViewModel.uploadImage(image, path: "profile", onSuccess: { [weak self] (url) in
//            self.doRegiser("\(url.absoluteString)")
            self?.form.profileImageUrl = url.absoluteString
            self?.doRegiser()
        }) { (_) in
            Loading.stopLoading(self)
        }
       
    }
    
    private func doRegiser() {
        viewModel.register(form.parameters, onSuccess: {  [weak self]  (user) in
            UserManager.shared.login(user)
            self?.dismiss(animated: true)
            Loading.stopLoading(self)
        }) { [weak self] (_) in
            print("error")
            self?.alert(title: "already user")
            Loading.stopLoading(self)
        }
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func selectImage() {
        // เลือก option รูป
        let alert: UIAlertController = UIAlertController(title: "Select Action", message: nil, preferredStyle: .actionSheet)
               
        // camera action
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.openCamera()
        }
        alert.addAction(cameraAction)
               
               
        // photo Library action
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] (_) in
            self?.openPhotoLibrary()
        }
               
        alert.addAction(photoLibraryAction)
               
        // cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) )
               
        present(alert, animated: true)
    }
    
    // STEP: 2
    private func openCamera() {
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    // STEP: 2
    private func openPhotoLibrary() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    // STEP: 3
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // ทำงานหลังจากเลือกรูปเสร็จ
        
        guard let image = info[.originalImage] as? UIImage else { return }
        form.profileImage = image
        tableView.reloadData()
        // ปิดหน้าเลือกรูป
        dismiss(animated: true)
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
            cell.profileImageView.image = form.profileImage != nil ? form.profileImage : UIImage(named: "PROFILE")
            cell.selectAction = selectImage
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
