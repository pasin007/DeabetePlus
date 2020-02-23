//
//  UrlManager.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation

enum UrlManager: String {
    case login,
        register,
        profile,
//        addUserProffile,
        friends,
    
        foods,
        scanFood,
        recommendFood,
        foodHistories,
    
    
        getOTP,
        checkOTP
    var path: String {
        switch self {
            
        case .login:
            return "\(KeyManager.baseURL)/auth/login"
        case .register:
            return "\(KeyManager.baseURL)/auth/register"
        case .profile:
            return "\(KeyManager.baseURL)/auth/me"
//        case .addUserProffile:
//            return "\(KeyManager.baseURL)/auth/addUserProffile"
        case .friends:
             return "\(KeyManager.baseURL)/auth/friends"
            
        case .foods:
            return "\(KeyManager.baseURL)/foods/"
        case .scanFood:
            return "\(KeyManager.baseURL)/foods/scan"
        case .recommendFood:
            return "\(KeyManager.baseURL)/foods/recommend"
        case .foodHistories:
            return "\(KeyManager.baseURL)/foods/histories"
            
        case .getOTP:
            return "\(KeyManager.baseURL)/auth/sendotp"
        case .checkOTP:
            return "\(KeyManager.baseURL)/auth/checkotp"
        
        }
    }
    
}
