//  UserDefaultManager.swift
//  SwiftBankingSystem

import Foundation

class UserDefaultManager : UserDefaults {
    
    static let shared = UserDefaultManager()
    
    fileprivate let customerNumKey = "customerNum"
    fileprivate let accountNumKey = "accountNum"
    
    fileprivate var preference: UserDefaults = {
        return UserDefaults.standard
    }()
    
    // Returns user id
    var accountNum: Int64? {
        set {
            preference.set(newValue, forKey: accountNumKey)
        }
        get {
            return Int64(preference.integer(forKey: accountNumKey))
        }
    }
    
    // Returns user id
    var customerNum: Int64? {
        set {
            preference.set(newValue, forKey: customerNumKey)
        }
        get {
            return Int64(preference.integer(forKey: customerNumKey))
        }
    }
}
