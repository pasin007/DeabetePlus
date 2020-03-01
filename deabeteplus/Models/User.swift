//
//  User.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
//    var email: String
    var birthdate: String
    var phone: String
    var gender: String
    var image: String?
//    var profiles: [UserProfile]
//    var currentProfile: UserProfile?
    var weight: Double
    var height: Double
    var age: Int
    var cal_perday: Double
    var today_eat: Double
    var bmis: [UserBmi]
//    var friends: [UserFriend]
//    var role_id: Int
//    var roleId
//    var current_profile: Int
}

//struct UserProfile: Codable {
//    var id: Int
//    var user_id: Int
//    var name: String
//    var phone: String
//    var type_id: Int
//    var image: String?
//}

struct UserBmi: Codable {
    var id: Int
    var user_id: Int
    var bmi: Double
    var weight: Double
    var height: Double
}
