//  Current.swift
//  SwiftBankingSystem

import Foundation

class Current : Account {
    var openingBalance : Double
    
    required init(accountNo:Int64,createdDate:String,customerNo:Int64,balance:Double,openingBalance:Double)
    {
        self.openingBalance = openingBalance
        super.init(accountNo: accountNo, createdDate: createdDate, customerNo: customerNo, balance: balance)
    }
    
    override func toString() -> String {
        return "Current [" + String(self.accountNo) + ";" + String(self.createdDate) + ";" + String(self.customerNo) + ";" + String(self.openingBalance) + ";" + String(self.balance) + "]"
    }
    
    // convert string to current account class
    static func parseCurrent(str: String) -> Current? {
        let str = str.replacingOccurrences(of: "Current [", with:"").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Current(accountNo: Int64(fields[0])!, createdDate: fields[1], customerNo: Int64(fields[2])!, balance: Double(fields[4])!, openingBalance: Double(fields[3])!)
        } else {
            print("Parsing Error")
            return nil
        }
    }
    
}
