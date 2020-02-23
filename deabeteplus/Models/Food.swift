//
//  Food.swift
//  deabeteplus
//
//  Created by pasin on 15/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation

struct Food: Codable {
    var id: Int
    var type: String
    var name: String
    var name_en: String
    var imageUrl: String
    var kcal: Float
    var protein: Float
    var fat: Float
    var carbo: Float
    var sodium: Float
}

struct RecommendFood: Codable {
    var cal_today: Int
    var foods: [Food]
}
