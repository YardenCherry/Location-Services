//
//  UserManager.swift
//  LocationServices
//
//  Created by Nadav Avnon on 11/07/2024.
//

import Foundation



class UserManager {
        
    public static let instance = UserManager()
    private init() {}
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
    
 
    func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
}
