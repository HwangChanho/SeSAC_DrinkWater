//
//  Image.swift
//  SeSAC_DrinkWater
//
//  Created by ChanhoHwang on 2021/10/10.
//

import Foundation

final class UserManager {
    static let shared  = UserManager()
    
    var user = User()
    
    init() {
        load()
    }
    
    func save() {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: Constants.userDefaultKey.userInfo)
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        do {
            if let data = UserDefaults.standard.data(forKey: Constants.userDefaultKey.userInfo) {
                let decoded = try JSONDecoder().decode(User.self, from: data)
                user = decoded
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func waterRecomend() -> Double {
        let result = (user.height + user.weight) / 100
        
        return result
    }
    
    func getImageName(_ percentage: Double) -> String {
        switch percentage {
        case 0 ..< 15:
            return "1-1"
        case 15 ..< 35:
            return "1-3"
        case 35 ..< 55:
            return "1-4"
        case 55 ..< 65:
            return "1-5"
        case 65 ..< 75:
            return "1-6"
        case 75 ..< 85:
            return "1-7"
        case 85 ..< 99:
            return "1-8"
        case 100:
            return "1-9"
        default:
            return "1-1"
        }
    }
    
}

