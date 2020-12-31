//  TransactionPanel.swift
//  SwiftBankingSystem

import Foundation

class TransactionPanel {
    func main() {
        print()
        print("Transaction Panel")
        print()
        while (true) {
            print("Choose from below transaction option:")
            print("1. Deposit money")
            print("2. Withdraw money")
            print("3. Transfer money")
            print("4. Pay utility bills")
            print("5. Show Transactions")
            print("0. Go back")
            let type = Int(readLine()!)!
            switch type{
            case 0:  return
            case 1:  depositTransaction()
            case 2:  withdrawTransaction()
            case 3:  transferTransaction()
            case 4:  payBillTransaction()
            case 5:  showTransaction()
            default:  print("Please choose valid option")
            }
        }
    }
    
    // method for deposit
    private func depositTransaction() {
        print("Enter the accountId: ")
        let accountNo = Int64(readLine()!)!
        print("Enter the amount: ")
        let amount = Double(readLine()!)!
        print("Enter the transaction Detail: ")
        let tranDetail = readLine()!
        print("Enter the person name: ")
        let personName = readLine()!
        print("Enter the type (cash/cheque): ")
        let type = readLine()!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let deposit = Deposit(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, personName: personName, type: type)
        let transactionId = deposit.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // method for withdraw
    private func withdrawTransaction() {
        let tranDetail = "Withdraw money"
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the check number: ")
        let checkNo = readLine()!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let withdraw = Withdraw(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, checkNo: checkNo)
        let transactionId = withdraw.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // method for transfer transaction
    private func transferTransaction() {
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the accountId where you want to transfer: ")
        let destinationAccountNo =  Int64(readLine()!)!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        print("Enter the transaction Detail: ")
        let tranDetail = readLine()!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let transfer = Transfer(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date,destinationAccountNo: destinationAccountNo)
        let transactionId = transfer.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    //    switch method for bill payments
    private func payBillTransaction() {
        print()
        while (true) {
            print("Pay utilities bills:")
            print("1. Hydro")
            print("2. Water")
            print("3. DTH")
            print("4. Mobile Recharge")
            print("0. Go back")
            let type = Int(readLine()!)
            switch (type) {
            case 0:  return
            case 1:  hydro()
            case 2:  water()
            case 3:  dth()
            case 4:  mobileBillPayment()
            default:  print("Please choose valid option")
            }
        }
    }
    
    // method for electric bill
    private func hydro() {
        let type = "Hydro"
        let tranDetail = "Hydro bill paid"
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the provider name: ")
        let provider = readLine()!
        print("Enter the consumer number: ")
        let consumerNo = readLine()!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let billPayment = BillPayment(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, consumerNo: consumerNo)
        let transactionId = billPayment.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // method for water bill
    private func water() {
        let type = "Water"
        let tranDetail = "Water bill paid"
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the provider name: ")
        let provider = readLine()!
        print("Enter the consumer number: ")
        let consumerNo = readLine()!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let billPayment = BillPayment(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, consumerNo: consumerNo)
        let transactionId = billPayment.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // method for dth bill
    private func dth() {
        let type = "DTH"
        let tranDetail = "DTH bill paid"
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the provider name: ")
        let provider = readLine()!
        print("Enter the consumer number: ")
        let consumerNo = readLine()!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let billPayment = BillPayment(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, consumerNo: consumerNo)
        let transactionId = billPayment.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // method for mobile bill
    private func mobileBillPayment() {
        let type = "Mobile"
        let tranDetail = "Mobile Recharge done"
        print("Enter the accountId: ")
        let accountNo =  Int64(readLine()!)!
        print("Enter the mobile number to recharge: ")
        let mobileNo =  Int64(readLine()!)!
        print("Enter the provider name: ")
        let provider = readLine()!
        print("Enter the amount: ")
        let amount =  Double(readLine()!)!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterPrint.string(from: Date())
        let mobilePayment = MobilePayment(amount: amount, tranDetail: tranDetail, accountNo: accountNo, date: date, type: type, provider: provider, mobileNo: mobileNo)
        let transactionId = mobilePayment.doTransaction()
        if (transactionId > 0) {
            print("Transaction done successfully. Transaction Id: \(transactionId)")
        } else {
            print("Transaction failed.")
        }
    }
    
    // show all transactions
    private func showTransaction() {
        print()
        print("Choose from below to see different transaction option:")
        print("1. Last 10 transaction of selcted account")
        print("2. Last 10 transaction of Deposite")
        print("3. Last 10 transaction of Withdraw")
        print("4. Last 10 transaction of Transfer money from one to other account")
        print("5. Last 10 transaction of utility bill payment")
        print("6. Last 10 mobile bill payment payment")
        print("0. Go back")
        let type = Int(readLine()!)
        var list: [BaseTransaction]? = nil
        switch (type) {
        case 0:  return
        case 1:
            print("Enter the accountId: ")
            let accountNo =  Int64(readLine()!)!
            list = SystemRepo.instance().lastTenTransaction(accountNo: accountNo)
        case 2:  list = SystemRepo.instance().lastTenDepositTransaction()
        case 3:  list = SystemRepo.instance().lastTenWithdrawTransaction()
        case 4:  list = SystemRepo.instance().lastTenTransferTransaction()
        case 5:  list = SystemRepo.instance().lastTenBillPaymentTransaction()
        case 6:  list = SystemRepo.instance().lastTenMobilePaymentTransaction()
        default:  print("Please choose valid option")
        }
        if (list != nil) {
            if (list!.count > 0) {
                print("-------------------")
                print("List of Transaction")
                print(list!.map({ (baseTran) -> String in
                    baseTran.toString()
                }).joined(separator: "\n"))
                print("-------------------")
            } else {
                print("No Transaction. \n")
            }
        } else {
            print("No Transaction. \n")
        }
    }
}
