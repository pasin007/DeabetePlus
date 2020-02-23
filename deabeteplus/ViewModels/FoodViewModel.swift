//
//  FoodViewModel.swift
//  deabeteplus
//
//  Created by pasin on 15/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation
import Alamofire

class FoodViewModel {
    
    func recommendFood(onSuccess: @escaping(RecommendFood) -> Void,  onError: @escaping(Error?) -> Void) {
        guard let user = UserManager.shared.currentUser else { return }
        let parms = ["user_id":user.id]
        Alamofire.request(UrlManager.recommendFood.path, method: .post, parameters: parms).responseJSON {
            (dataResponse) in
            guard let data = dataResponse.data else {
                onError(nil)
                return
            }
//            print(dataResponse.value)
            do {
                let decode: JSONDecoder = JSONDecoder()
                let recommendFood = try decode.decode(RecommendFood.self, from: data)
                onSuccess(recommendFood)
            } catch {
                print(error)
                print(error.localizedDescription)
                onError(error)
            }
        }
    }
    
    func scanFood(_ parms: [String:Any], onSuccess: @escaping(FoodScanResponse) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.scanFood.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
//            print(dataResponse.value)
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }
            do {
                let decode: JSONDecoder = JSONDecoder()
                let response =  try decode.decode(FoodScanResponse.self, from: data)
                onSuccess(response)
            } catch {
                print(error)
                print(error.localizedDescription)
                onError(error)
            }

        }
    }
    
    func getFood(_ name: String, onSuccess: @escaping(Food) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.foods.path + "food/" + name, method: .get).responseData { (dataResponse) in
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }
                   
            let decode: JSONDecoder = JSONDecoder()
            guard let food =  try? decode.decode(Food.self, from: data) else {
                onError(nil)
                return
            }
            onSuccess(food)
        }
    }
    
    func getFoods(onSuccess: @escaping([Food]) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.foods.path, method: .get).responseData { (dataResponse) in
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }
                   
            let decode: JSONDecoder = JSONDecoder()
            guard let foods =  try? decode.decode([Food].self, from: data) else {
                onError(nil)
                return
            }
            onSuccess(foods)
        }
    }
    
    
}
