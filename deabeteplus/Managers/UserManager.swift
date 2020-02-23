//
//  UserManager.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation

class UserManager {
    
    static var shared: UserManager = UserManager()
    
    var currentUser: User? = nil {
        didSet {
            guard let user = currentUser else {
                userId = nil
                return
            }
            userId = user.id
        }
        
    }
    
    let userDefault: UserDefaults = UserDefaults.standard
    
    var userId: Int? {
        set {
            userDefault.set(newValue, forKey: KeyManager.keyUserId)
        }
        
        get {
            guard let userId = userDefault.value(forKey: KeyManager.keyUserId) as? Int else { return nil }
            return userId
        }
    }
    
    var isLogin: Bool {
        get {
            return userId != nil
        }
    }
    
    func logut() {
        currentUser = nil
    }
    
    func login(_ user: User) {
        currentUser = user
    }
}


