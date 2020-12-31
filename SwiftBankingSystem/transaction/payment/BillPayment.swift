//  BillPayment.swift
//  SwiftBankingSystem

import Foundation

class BillPayment : BaseTransaction {
    
    
    var tranID: Int64 = 0
    var amount: Double
    var tranDetail: String
    var accountNo: Int64
    var date: String
    var type: String
    var provider: String
    var consumerNo: String?
    
    init(tranId: Int64, amount: Double, tranDetail: String, accountNo: Int64, date: String, type: String, provider: String, consumerNo: String?) {
        self.tranID = tranId
        self.amount = amount
        self.tranDetail = tranDetail
        self.accountNo = accountNo
        self.date = date
        self.type = type
        self.provider = provider
        self.consumerNo = consumerNo
    }
    
    convenience init(amount: Double, tranDetail: String, accountNo: Int64, date: String, type: String, provider: String, consumerNo: String?){
        self.init(tranId: Self.generateTransactionId(), amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, consumerNo: consumerNo)
    }
    
    // method for calculate amount and save transaction
    func doTransaction() -> Int64 {
        let srcAccount = getAccount(accountNo: accountNo)
        if (isAccountValid(account: srcAccount)) {
            let remainBalance = srcAccount!.balance - amount
            if (remainBalance > 0) {
                srcAccount!.balance = srcAccount!.balance - amount
                SystemRepo.instance().updateAccount(account: srcAccount!)
                return SystemRepo.instance().billPaymentTransaction(billPayment: self)
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
        return "BillPayment [" + String(self.tranID) + ";" + String(self.accountNo) + ";" + String(self.amount) + ";" + self.type + ";" + self.provider + ";" + String(self.consumerNo ?? "") + ";" + self.tranDetail + ";" + self.date + "]"
    }
    
    // convert string to Bill payment transaction class
    static func parseBillPayment(str: String) -> BillPayment? {
        
        let str = str.replacingOccurrences(of: "BillPayment [", with: "").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return BillPayment(tranId: Int64(fields[0])!, amount: Double(fields[2])!,
                               tranDetail: fields[6], accountNo: Int64(fields[1])!, date: fields[7], type: fields[3], provider: fields[4], consumerNo: fields[5])
        } else {
            print("Parsing Error")
            return nil
        }
    }
    
}
