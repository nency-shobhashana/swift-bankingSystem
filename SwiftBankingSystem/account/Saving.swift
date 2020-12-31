//  Saving.swift
//  SwiftBankingSystem

import Foundation

class Savings : Account {
    var openingBalance : Double
    var annualInterest : Double
    
    required init(accountNo:Int64,createdDate:String, customerNo:Int64,balance:Double,openingBalance : Double,annualInterest:Double)
    {
        self.openingBalance = openingBalance
        self.annualInterest = annualInterest
        super.init(accountNo: accountNo, createdDate: createdDate, customerNo: customerNo, balance: balance)
    }
    
    override func toString() -> String {
        return "Savings [" + String(self.accountNo) + ";" + String(self.createdDate) + ";" + String(self.customerNo) + ";" + String(self.openingBalance) + ";"
            + String(self.annualInterest) + ";" + String(self.balance) + "]"
    }
    
    // convert string to Saving account class
    static func parseSavings(str: String) -> Savings? {
        let str = str.replacingOccurrences(of: "Savings [", with:"").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Savings(accountNo: Int64(fields[0])!, createdDate: fields[1], customerNo: Int64(fields[2])! ,balance: Double(fields[5])!, openingBalance: Double(fields[3])!, annualInterest: Double(fields[4])!)
        } else {
            print("Parsing Error")
            return nil
        }
    }
    
}
