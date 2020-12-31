//  MobilePayment.swift
//  SwiftBankingSystem

import Foundation

class MobilePayment : BillPayment {
    var mobileNo: Int64
    
    convenience init(amount: Double, tranDetail: String, accountNo: Int64, date: String, type: String, provider: String, mobileNo: Int64){
        self.init(tranId: Self.generateTransactionId(), amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, mobileNo: mobileNo)
    }
    
    init(tranId: Int64, amount: Double, tranDetail: String, accountNo: Int64, date: String, type: String, provider: String, mobileNo: Int64) {
        self.mobileNo = mobileNo
        super.init(tranId: tranId, amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, consumerNo: nil)
    }
    
    // method for calculate amount and save transaction
    override func doTransaction() -> Int64 {
        let srcAccount = getAccount(accountNo: accountNo)
        if (isAccountValid(account: srcAccount)) {
            let remainBalance = srcAccount!.balance - amount
            if (remainBalance > 0) {
                srcAccount!.balance = srcAccount!.balance - amount
                SystemRepo.instance().updateAccount(account: srcAccount!)
                return SystemRepo.instance().mobilePaymentTransaction(mobilePayment: self)
            } else {
                print("Not sufficent balance in account; Your account balance is \(srcAccount!.balance)" )
                return -1
            }
        } else {
            print("Account no is invalid or does not exist")
            return -1
        }
    }
    
    override func toString() -> String {
        return "MobilePayment [" + String(self.tranID) + ";" + String(self.accountNo) + ";" + String(self.amount) + ";" + self.type + ";" + self.provider + ";" + String(self.mobileNo) + ";" + self.tranDetail + ";" + self.date + "]"
    }
    
    // convert string to Mobile payment transaction class
    static func parseMobilePayment(str: String) -> MobilePayment? {
        let str = str.replacingOccurrences(of: "MobilePayment [", with: "").replacingOccurrences(of: "]", with: "")
        let fields = str.components(separatedBy: ";")
        if (fields.count > 0) {
            return MobilePayment(tranId: Int64(fields[0])!, amount: Double(fields[2])!, tranDetail: fields[6], accountNo: Int64(fields[1])!, date: fields[7], type: fields[3], provider: fields[4], mobileNo: Int64(fields[5])!)
        } else {
            print("Parsing Error")
            return nil
        }
    }
}
