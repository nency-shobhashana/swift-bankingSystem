//  Transfer.swift
//  SwiftBankingSystem

import Foundation

class Transfer: BaseTransaction {
    
    var tranID: Int64 = 0
    var amount: Double
    var tranDetail: String
    var accountNo: Int64
    var date: String
    var destinationAccountNo: Int64 = 0
    
    init(tranId: Int64, amount: Double, tranDetail: String, accountNo: Int64, date: String, destinationAccountNo: Int64) {
        self.tranID = tranId
        self.amount = amount
        self.tranDetail = tranDetail
        self.accountNo = accountNo
        self.date = date
        self.destinationAccountNo = destinationAccountNo
    }
    
    convenience init(amount: Double, tranDetail: String, accountNo: Int64, date: String, destinationAccountNo: Int64){
        self.init(tranId: Self.generateTransactionId(), amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, destinationAccountNo: destinationAccountNo)
    }
    
    private var destAccount: Account? {
        get{
            return SystemRepo.instance().getAccount(accountNo: destinationAccountNo)
        }
    }
    
    // method for calculate amount and save transaction
    func doTransaction() -> Int64 {
        let srcAccount = getAccount(accountNo: accountNo)
        let destinationAccount = destAccount
        if (!isAccountValid(account: srcAccount)) {
            print("Account no is invalid or does not exist")
            return -1
        }
        if (!isAccountValid(account: destinationAccount)) {
            print("Destination Account no is invalid or does not exist")
            return -1
        }
        let remainBalance = srcAccount!.balance - amount
        if (remainBalance > 0) {
            srcAccount!.balance = srcAccount!.balance - amount
            destinationAccount!.balance = destinationAccount!.balance + amount
            SystemRepo.instance().updateAccount(account: srcAccount!)
            SystemRepo.instance().updateAccount(account: destinationAccount!)
            return SystemRepo.instance().transferTransaction(transfer: self)
        } else {
            print("Not sufficent balance in account; Your account balance is \(srcAccount!.balance)")
            return -1
        }
    }
    
    func toString() -> String {
        return ("Transfer [" + String(self.tranID) + ";" + String(self.accountNo) + ";" + String(self.amount) + ";" + String(self.destinationAccountNo) + ";" + self.tranDetail + ";" + self.date + "]")
    }
    
    // convert string to Transfer transaction class
    static func parseTransfer(str: String) -> Transfer? {
        let str = str.replacingOccurrences(of: "Transfer [", with: "").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return Transfer(tranId: Int64(fields[0])!, amount: Double(fields[2])!, tranDetail: fields[4], accountNo: Int64(fields[1])!, date: fields[5], destinationAccountNo: Int64(fields[3])!)
        } else {
            print("Parsing Error")
            return nil
        }
    }
}
