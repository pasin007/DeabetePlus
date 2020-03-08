//
//  FoodViewController.swift
//  deabeteplus
//
//  Created by pasin on 19/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, BaseViewController {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextfile: UITextField!
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    
    // MARK: Properties
    private var food: Food!
    private var newFood: Food!
    private var picker: UIPickerView = UIPickerView()
    private var values: [String] = [ "ธรรมดา", "พิเศษ", "ครึ่งจาน"]
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        configureView(food)
        createPicker()
        // Do any additional setup after loading the view.
    }

    @IBAction func doEat() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func createPicker() {
        // set delegate & dataSource
        picker.delegate = self
        picker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.done))
        toolbar.setItems([done], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        valueTextfile.inputAccessoryView = toolbar
        valueTextfile.inputView = picker
    }
    
    @objc func done() {
        if valueTextfile.text == "" {
            valueTextfile.text = values[0]
        }
        setValue()
        view.endEditing(true)
    }
}

extension FoodViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = values[row]
        valueTextfile.text = value
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /// row
        let value = values[row]
        return value
    }
    
}
// MARK: Configuration
extension FoodViewController {
    func configure(_ food: Food) {
        self.food = food
        newFood = food
    }
    
    func configureView(_ food: Food) {
        titleLabel.text = food.name
        calLabel.text = "\(food.kcal)"
//        sugarLabel.text = "\(food.)"
        proteinLabel.text = "\(food.protein)"
        carbLabel.text = "\(food.carbo)"
        fatLabel.text = "\(food.fat)"
        sodiumLabel.text = "\(food.sodium)"
    }
    
    func setValue() {
        let value = valueTextfile.text ?? ""
        guard let index = values.firstIndex(of: value) else { return }
           print("index : \(index), value : \(value)")
        switch index {
        case 0:
             configureView(food)
        case 1:
             changeValue(percent: 20)
        case 2:
             changeValue(percent: 50, isUp: false)
        default: break
        }
        
     
       
    }
    
    func changeValue(percent: Float, isUp: Bool = true) {
        if isUp {
            newFood.kcal = food.kcal + (food.kcal * percent / 100)
            newFood.protein = food.kcal + (food.protein * percent / 100)
            newFood.carbo = food.kcal + (food.carbo * percent / 100)
            newFood.fat = food.kcal + (food.fat * percent / 100)
            newFood.sodium = food.kcal + (food.sodium * percent / 100)
        } else {
            newFood.kcal = (food.kcal * percent / 100)
            newFood.protein = (food.protein * percent / 100)
            newFood.carbo = (food.carbo * percent / 100)
            newFood.fat = (food.fat * percent / 100)
            newFood.sodium = (food.sodium * percent / 100)
        }
        
        configureView(newFood)
    }
}
