//
//  FoodScanResponse.swift
//  deabeteplus
//
//  Created by pasin on 26/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import Foundation

struct FoodScanResponse: Codable  {
    var status: Bool
    var insulin: Int
    var insulin_status: Int
}

