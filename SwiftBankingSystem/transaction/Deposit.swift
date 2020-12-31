//  Deposit.swift
//  SwiftBankingSystem

import Foundation

class Deposit: BaseTransaction {
    
    var tranID: Int64 = 0
    var amount: Double
    var tranDetail: String
    var accountNo: Int64
    var date: String
    var personName: String
    var type: String
    
    init(tranId: Int64, amount: Double, tranDetail: String, accountNo: Int64, date: String, personName: String, type: String) {
        self.tranID = tranId
        self.amount = amount
        self.tranDetail = tranDetail
        self.accountNo = accountNo
        self.date = date
        self.personName = personName
        self.type = type
    }
    
    convenience init(amount: Double, tranDetail: String, accountNo: Int64, date: String, personName: String, type: String){
        self.init(tranId: Self.generateTransactionId(), amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, personName: personName, type: type)
    }
    
    // method for calculate amount and save transaction
    func doTransaction() -> Int64 {
        let srcAccount = getAccount(accountNo: accountNo)
        if (isAccountValid(account: srcAccount)) {
            srcAccount!.balance = srcAccount!.balance + amount
            SystemRepo.instance().updateAccount(account: srcAccount!)
            return SystemRepo.instance().depositTransaction(deposit: self)
        } else {
            print("Account no is invalid or does not exist")
            return -1
        }
    }
    
    func toString() -> String {
        return "Deposit [" + String(self.tranID) + ";" + String(self.accountNo) + ";" + String(self.amount) + ";" + self.personName + ";" + self.tranDetail + ";" + self.type + ";" + self.date + "]"
    }
    
    
    // convert string to Deposit transaction class
    static func parseDeposit(str: String) -> Deposit? {
        let str = str.replacingOccurrences(of: "Deposit [", with:"").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Deposit(tranId: Int64(fields[0])!, amount: Double(fields[2])!, tranDetail: fields[4],  accountNo: Int64(fields[1])!, date: fields[6], personName: fields[3], type: fields[5])
        } else {
            print("Parsing Error")
            return nil
        }
    }
}
