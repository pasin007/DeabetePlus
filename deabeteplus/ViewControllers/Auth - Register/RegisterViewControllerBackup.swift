//
//  RegisterViewController.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

class RegisterViewBackupController: UIViewController, BaseViewController {

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
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var heightTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    private var viewModel: UserViewModel = UserViewModel()
    private var imageViewModel: ImageViewModel = ImageViewModel()
    
    private var pickerGender: UIPickerView = UIPickerView()
    
    private var pickerDate: UIDatePicker = UIDatePicker()
    
    private var picker: UIImagePickerController = UIImagePickerController()
    
    private var isShowPassword: Bool = false {
        didSet {
            passwordTextfield.isSecureTextEntry = !isShowPassword
        }
    }
    private var birthdate: String = ""
    
    private var selectImage: UIImage? = nil
    private var imageUrlString: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        createDatePicker()
        createGenderPicker()
    }


}

/// MARK: Function
extension RegisterViewBackupController {
    @IBAction func doShowPassword() {
        isShowPassword = !isShowPassword
    }
    
    @IBAction func navigatorToLogin() {
//        Navigator.shared.navigatorToLogin(self)
        navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func register() {
        if let image = selectImage {
            imageViewModel.uploadImage(image, path: "profile", onSuccess: { (url) in
                self.doRegiser("\(url.absoluteString)")
            }) { (_) in
                       
            }
            return
        }
        doRegiser()
    }
    
    private func doRegiser(_ imageUrl: String? = nil) {
        guard let email = emailTextfield.text,
             let password = passwordTextfield.text,
             let name = nameTextfield.text,
             let gender = genderTextfield.text,
             let phone = phoneTextfield.text,
             let weight = weightTextfield.text,
             let height = heightTextfield.text,
             !email.trim.isEmpty,
             !password.trim.isEmpty,
             !name.trim.isEmpty,
             !birthdate.trim.isEmpty,
             !gender.trim.isEmpty,
             !phone.trim.isEmpty,
             !weight.trim.isEmpty,
             !height.trim.isEmpty
             else { return }
         
         var parms: [String:Any] = [
             "email": email,
             "password": password,
             "name": name + " ",
             "gender": gender,
             "birthdate": birthdate,
             "phone" : phone,
             "weight" : weight,
             "height" : height
         ]
         if let image = imageUrl {
             parms["image"] = image
         }
         viewModel.register(parms, onSuccess: { [weak self] (user) in
             UserManager.shared.login(user)
             self?.dismiss(animated: true)
         }) { (error) in
             // do something ....
         }
    }

}

/// MARK: Date Picker
extension RegisterViewBackupController {
    func createDatePicker() {
        // 1 - configure Date Picker
        pickerDate.datePickerMode = .date
        pickerDate.calendar = Calendar(identifier: .buddhist)
        pickerDate.locale = Locale(identifier: "th")
        
        // 2 - create tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 3 - add toolbar action
        let done = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(self.showdate))
        toolbar.setItems([done], animated: false)
        
        // 4 - set inputView
        dateTextfield.inputAccessoryView = toolbar
        dateTextfield.inputView = pickerDate
    }
    
    @objc func showdate(){
//        print("date : \(pickerDate.date)")
        
        // 5 - create formatter to text field
        let dateformate = DateFormatter()
        dateformate.locale = Locale(identifier: "th")
        dateformate.dateFormat = "dd MMMM yyyy"
        
        // 6 - formatter date
        let string = dateformate.string(from: pickerDate.date)
        dateTextfield.text = string
        
        
          // 5 - create formatter to database
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        formater.locale = Locale(identifier: "th")
        
        birthdate = formater.string(from: pickerDate.date)
        
        
        view.endEditing(true)
    }
}

extension RegisterViewBackupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // STEP: 1
    @IBAction func openPickerAction() {
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
    
    // STEP: 3
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // ทำงานหลังจากเลือกรูปเสร็จ
        
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        selectImage = image
        
        // ปิดหน้าเลือกรูป
        dismiss(animated: true)
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
}

/// MARK: PickView
extension RegisterViewBackupController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /// row
        guard let gender = Gender(rawValue: row) else { return nil }
        return gender.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let gender = Gender(rawValue: row) else { return }
        genderTextfield.text = gender.title
    }
    
    
    func createGenderPicker() {
        // set delegate & dataSource
        pickerGender.delegate = self
        pickerGender.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        let done = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(self.done))
        toolbar.setItems([done], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        genderTextfield.inputAccessoryView = toolbar
        genderTextfield.inputView = pickerGender
    }
    
    
    @objc func done() {
        if genderTextfield.text == "" {
            genderTextfield.text = Gender.male.title
        }
        view.endEditing(true)
    }
    
}
