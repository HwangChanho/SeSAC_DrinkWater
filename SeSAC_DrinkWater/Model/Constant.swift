//
//  Constant.swift
//  SeSAC_DrinkWater
//
//  Created by ChanhoHwang on 2021/10/10.
//

import Foundation

struct Constants {
    
    #if DEBUG
    static let baseURL: String = "www.debug.com"
    #else
    static let baseURL: String = "www.eaefkekfk.com"
    #endif
    
    struct userDefaultKey {
        static let userInfo = "USER_INFO"
    }
}
