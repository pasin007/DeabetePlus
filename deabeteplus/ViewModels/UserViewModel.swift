//
//  UserViewModel.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation
import Alamofire

class UserViewModel {
    
    func login(_ parms: [String:Any], onSuccess: @escaping(User) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.login.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }
            print(dataResponse.value)
            do {
                let decode: JSONDecoder = JSONDecoder()
                let user =  try decode.decode(User.self, from: data)
                onSuccess(user)
            } catch {
                print(error)
                print(error.localizedDescription)
                onError(error)
            }
        }
    }
    
    func register(_ parms: [String:Any], onSuccess: @escaping(User) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.register.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
            print(dataResponse.value)
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }

            do {
                let decode: JSONDecoder = JSONDecoder()
                let user =  try decode.decode(User.self, from: data)
                onSuccess(user)
            } catch {
                print(error)
                print(error.localizedDescription)
                onError(error)
            }
        }
    }
    
    func getProfile(_ id: Int, onSuccess: @escaping(User) -> Void, onError: @escaping(Error?) -> Void) {
        Alamofire.request(UrlManager.profile.path, method: .post, parameters: ["id":id]).responseData { (dataResponse) in
            guard let data = dataResponse.data else {
                // do something...
                onError(nil)
                return
            }

            do {
                let decode: JSONDecoder = JSONDecoder()
                let user =  try decode.decode(User.self, from: data)
                onSuccess(user)
            } catch {
                print(error)
                print(error.localizedDescription)
                onError(error)
            }

        }
    }
    
    func sendOTP(_ phoneNumber: String, completion: @escaping(Bool) -> Void) {
//        guard let userId = UserManager.shared.userId else { return }
        let parms: [String:Any] = [
//            "id": userId,
            "phone": phoneNumber
        ]
        Alamofire.request(UrlManager.getOTP.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
            guard let data = dataResponse.value as? [String:Any], let status = data["status"] as? Bool else {
                // do something...
                completion(false)
                return
            }
            
            completion(status)
        }
    }
    
    func checkOTP(_ otp: String, completion: @escaping(User?) -> Void) {
//        guard let userId = UserManager.shared.userId else { return }
        let parms: [String:Any] = [
//            "id": userId,
            "otp": otp
        ]
        Alamofire.request(UrlManager.checkOTP.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
            
            print(dataResponse.value)
            guard let data = dataResponse.data else {
                // do something...
                completion(nil)
                return
            }

            do {
                let decode: JSONDecoder = JSONDecoder()
                let user =  try decode.decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
                print(error.localizedDescription)
                completion(nil)
            }

            
//            guard let data = dataResponse.value as? [String:Any], let status = data["status"] as? Bool else {
//                // do something...
//                completion(false)
//                return
//            }
//
//            completion(status)
        }
    }
    
    func getFriends(completion: @escaping([Friend]) -> Void) {
        guard let userId = UserManager.shared.userId else { return }
        let parms: [String:Any] = [
            "id": userId
        ]
        
        Alamofire.request(UrlManager.friends.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
            guard let data = dataResponse.data else {
                // do something...
                completion([])
                return
            }
            
            do {
                let decode: JSONDecoder = JSONDecoder()
                let friends =  try decode.decode([Friend].self, from: data)
                completion(friends)
            } catch {
                print(error)
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getFoodHistories(_ userId: Int, completion: @escaping([Double]) -> Void) {
        let parms: [String:Any] = [
            "id": userId
        ]
        
        Alamofire.request(UrlManager.foodHistories.path, method: .post, parameters: parms).responseJSON { (dataResponse) in
//            debugPrint(dataResponse.value)
            guard let value = dataResponse.value as? [String:Any],
                let histories = value["histories"] as? [Double] else {
                completion([])
                return
            }
            
           completion(histories)
        }
    }
}
