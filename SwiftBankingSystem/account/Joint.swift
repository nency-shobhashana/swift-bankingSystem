//  Joint.swift
//  SwiftBankingSystem

import Foundation

class Joint : Account {
    var openingBalance : Double
    var jointHolderName : String
    var holderRelationship : String
    
    required init(accountNo:Int64,createdDate:String, customerNo:Int64,balance:Double,openingBalance:Double,jointHolderName:String,holderRelationship:String)
    {
        self.openingBalance = openingBalance
        self.jointHolderName = jointHolderName
        self.holderRelationship = holderRelationship
        super.init(accountNo: accountNo, createdDate: createdDate, customerNo: customerNo, balance: balance)
    }
    
    override func toString() ->String
    {
        return "Joint [" + String(self.accountNo) + ";" + self.createdDate + ";" + String(self.customerNo) + ";" + String(self.openingBalance) + ";"
            + self.jointHolderName + ";" + self.holderRelationship + ";" + String(self.balance) + "]"
    }
    
    // convert string to Joint account class
    static func parseJoint(str: String) -> Joint? {
        let str = str.replacingOccurrences(of: "Joint [", with:"").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Joint(accountNo: Int64(fields[0])!, createdDate: fields[1], customerNo: Int64(fields[2])!, balance: Double(fields[6])!, openingBalance: Double(fields[3])!, jointHolderName: fields[4], holderRelationship: fields[5])
        } else {
            print("Parsing Error")
            return nil
        }
    }
}
