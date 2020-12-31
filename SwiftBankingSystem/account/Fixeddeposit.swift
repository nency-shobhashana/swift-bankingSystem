//  Fixeddeposit.swift
//  SwiftBankingSystem

import Foundation

class Fixeddeposit : Account {
    var depositAmount : Double
    var interestRate : Double
    var timePeriod : Double
    
    required init(accountNo:Int64,createdDate:String, customerNo:Int64,balance:Double,depositAmount:Double,interestRate:Double,timePeriod:Double)
    {
        self.depositAmount = depositAmount
        self.interestRate = interestRate
        self.timePeriod = timePeriod
        super.init(accountNo: accountNo, createdDate: createdDate, customerNo: customerNo, balance: balance)
    }
    
    override func toString() -> String {
        return "Fixeddeposit [" + String(self.accountNo) + ";" + self.createdDate + ";" + String(self.customerNo) + ";" + String(self.depositAmount) + ";"
            + String(self.interestRate) + ";" + String(self.timePeriod) + ";" + String(self.balance) + "]"
    }
    
    // convert string to Fixed deposit account class
    static func parseFixeddeposit(str: String) -> Fixeddeposit? {
        let str = str.replacingOccurrences(of: "Fixeddeposit [", with:"").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Fixeddeposit(accountNo: Int64(fields[0])!, createdDate: fields[1], customerNo: Int64(fields[2])!, balance: Double(fields[6])!, depositAmount: Double(fields[3])!, interestRate: Double(fields[4])!, timePeriod: Double(fields[5])!)
        } else {
            print("Parsing Error")
            return nil
        }
    }
}
