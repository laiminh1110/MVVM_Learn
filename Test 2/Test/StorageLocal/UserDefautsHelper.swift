//
//  UserDefautsHelper.swift
//  Test
//
//  Created by Minh on 30/11/2022.
//

import Foundation



class StorageUserDefaut {
    static let shared : StorageUserDefaut = {
        let instance = StorageUserDefaut()
        return instance
    }()
    
    let tokenKey = "tokenKey"
    
    init(){
        
    }
    
    var token: String {
        get {
            return UserDefaults.standard.string(forKey: tokenKey)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    func clearUserDefaut(){
        token = "" 
    }
}
