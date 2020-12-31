//  Account.swift
//  SwiftBankingSystem

import Foundation

class Account {
    var accountNo : Int64 = 0
    var createdDate : String = ""
    var customerNo : Int64 = 0
    var balance : Double = 0.0
    
    init(accountNo:Int64, createdDate:String, customerNo:Int64, balance:Double) {
        self.accountNo = accountNo
        self.createdDate = createdDate
        self.customerNo = customerNo
        self.balance = balance
    }
    
    func toString() -> String {
        return ""
    }
    
}
