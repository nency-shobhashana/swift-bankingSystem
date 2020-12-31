//  Withdraw.swift
//  SwiftBankingSystem

import Foundation

class Withdraw: BaseTransaction {
    
    var tranID: Int64 = 0
    var amount: Double
    var tranDetail: String
    var accountNo: Int64
    var date: String
    var checkNo: String
    
    init(tranId: Int64, amount: Double, tranDetail: String, accountNo: Int64, date: String, checkNo: String) {
        self.tranID = tranId
        self.amount = amount
        self.tranDetail = tranDetail
        self.accountNo = accountNo
        self.date = date
        self.checkNo = checkNo
    }
    
    convenience init(amount: Double, tranDetail: String, accountNo: Int64, date: String, checkNo: String){
        self.init(tranId: Self.generateTransactionId(), amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, checkNo: checkNo)
    }
    
    // method for calculate amount and save transaction
    func doTransaction() -> Int64 {
        let srcAccount = getAccount(accountNo: accountNo)
        if (isAccountValid(account: srcAccount)) {
            let remainBalance = srcAccount!.balance - amount
            if (remainBalance > 0) {
                srcAccount!.balance = srcAccount!.balance - amount
                SystemRepo.instance().updateAccount(account: srcAccount!)
                return SystemRepo.instance().withdrawTransaction(withdraw: self)
            } else {
                print("Not sufficent balance in account; Your account balance is \(srcAccount!.balance)")
                return -1
            }
        } else {
            print("Account no is invalid or does not exist")
            return -1
        }
    }
    
    func toString() -> String {
        return "Withdraw [" + String(self.tranID) + ";" + String(self.accountNo) + ";" + String(self.amount) + ";" + self.checkNo + ";" + self.tranDetail + ";" + self.date + "]"
    }
    
    // convert string to Withdraw transaction class
    static func parseWithdraw(str: String) ->  Withdraw? {
        let str = str.replacingOccurrences(of: "Withdraw [", with:"").replacingOccurrences(of: "]", with:"")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Withdraw(tranId: Int64(fields[0])!, amount: Double(fields[2])!, tranDetail: fields[4],  accountNo: Int64(fields[1])!, date: fields[5], checkNo: fields[3])
        } else {
            print("Parsing Error")
            return nil
        }
        
    }
}
