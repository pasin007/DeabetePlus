//
//  FoodDetailViewController.swift
//  deabeteplus
//
//  Created by pasin on 15/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

protocol FoodDetailViewControllerDelegate {
    var statusScan: Bool { get set }
    var foodImage: UIImage? { get set }
}

class FoodDetailViewController: UIViewController, BaseViewController {
    
    
    //MARK: Properties
    var food: Food!
    var delegate: FoodDetailViewControllerDelegate!
    
    var foodImageUrl: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carboLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    private let imageViewModel: ImageViewModel = ImageViewModel()
    private let foodViewModel: FoodViewModel = FoodViewModel()
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }

}


// MARK: Function
extension FoodDetailViewController {
    @IBAction func doClose() {
        dismiss(animated: true) { [weak self] in
            self?.delegate.statusScan = false
        }
    }
    
    @IBAction func doEat() {
        uploadImage(food.name_en)
    }
    
    @IBAction func dontEat() {
        dismissView()
    }
    
    private func uploadImage(_ name: String) {
        guard let image = foodImageView.image else { return }
        Loading.startLoading(self)
        imageViewModel.uploadImage(image, path: "scan", onSuccess: { [weak self] (url) in
            print(url.absoluteString)
            self?.doSaveScanHistory(name,url.absoluteString)
            
        }) { (error) in
              Loading.stopLoading(self)
        }
    }
    
    private func doSaveScanHistory(_ name: String,_ imageUrl: String) {
        let parms: [String:Any] = [
            "user_id" : UserManager.shared.userId!,
            "image" : imageUrl,
            "name" : name
        ]
        foodViewModel.scanFood(parms, onSuccess: { [weak self] (response) in
            Loading.stopLoading(self)
            
            let txt = response.status ? "กินอาหารเกิน" : ""
            
            var txt2 = ""
            switch response.insulin_status {
                case 1:
                    txt2 = " Carbohydrate ขาดอีก \(response.insulin)"
                case 2:
                    txt2 = " Carbohydrate เกินมา \(response.insulin)"
                default: break
            }
            
            let sumText = txt + txt2
            if sumText != "" {
                 self?.alert(title: sumText, completionButton: { (_) in
                     self?.doClose()
                 })
            } else {
                 self?.doClose()
            }
            
        }) { (error) in
            Loading.stopLoading(self)
        }
    }
}

// MARK: Pass Data form delegate
extension FoodDetailViewController {
    private func initView() {
        nameLabel.text = "name : " + food.name
        proteinLabel.text = "protein : \(food.protein) กรัม"
        carboLabel.text = "carbo : \(food.carbo) กรัม"
        sodiumLabel.text = "sodium : \(food.sodium) มิลลิกรัม"
        kcalLabel.text = "kcal : \(food.kcal) กิโลเเคลอรี่"
        fatLabel.text = "fat : \(food.fat) กรัม"
        
        foodImageView.image = delegate.foodImage
}
}

