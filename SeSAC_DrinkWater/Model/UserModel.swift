//
//  userDefaults.swift
//  SeSAC_DrinkWater
//
//  Created by ChanhoHwang on 2021/10/10.
//

import UIKit

struct User: Codable {
    var userName: String = "default"
    var height: Double = 0
    var weight: Double = 0
    var drunkenTotal: Double = 0
    var currentImage: String = "1-1"
    var totalPercent: Int = 0
}
