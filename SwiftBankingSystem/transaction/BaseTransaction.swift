//  BaseTransaction.swift
//  SwiftBankingSystem

import Foundation

protocol TransactionProtocol {
    
    var tranID: Int64 { get set }
    var amount: Double { get set }
    var tranDetail: String { get set }
    var accountNo: Int64 { get set }
    var date: String { get set }
    
    func doTransaction() -> Int64
    
    func toString() -> String
}

class Transaction {
    static var lastTranID: Int64  = 0
    
    // get latest transaction id either from file or system
    static func generateTransactionId() -> Int64 {
        if (lastTranID == 0) {
            let transactionIdFromfile: Int64 = SystemRepo.instance().lastTransId()
            if (transactionIdFromfile == 0) {
                lastTranID = 100000000
            } else {
                lastTranID = transactionIdFromfile
            }
        }
        lastTranID = lastTranID + 1
        return lastTranID
    }
    
    // method of account is valid or not
    func isAccountValid(account: Account?) -> Bool {
        return account != nil && !(account is Fixeddeposit)
    }
    
    // get account from account no
    func getAccount(accountNo: Int64) -> Account?{
        return SystemRepo.instance().getAccount(accountNo: accountNo)
    }
}

// combine protocol and class
typealias BaseTransaction = Transaction & TransactionProtocol
