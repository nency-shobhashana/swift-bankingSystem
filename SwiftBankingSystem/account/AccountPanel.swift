//  AccountPanel.swift
//  SwiftBankingSystem

import Foundation

class AccountPanel {
    let preference = UserDefaultManager.shared
    var accountList = [Account]()
    var lastCustomerNum: Int64

    init(){
        lastCustomerNum = preference.accountNum ?? 0
    }
    
    func main() {
        print("\nAccount Panel\n")
        while (true) {
            print("Choose from below option:")
            print("1. savings account")
            print("2. current account")
            print("3. fixed deposit account")
            print("4. joint account")
            print(" press  0  number to exit")
            
            print("Choose option ")
            let opt = Int(readLine()!)!
            switch opt {
            
            case 0:
                return
            case 1:
                accountList = SystemRepo.instance().readAccountsFromFile()
                savings()
                break
            case 2:
                accountList = SystemRepo.instance().readAccountsFromFile()
                current()
                break
            case 3:
                accountList = SystemRepo.instance().readAccountsFromFile()
                fixeddeposit()
                break
            case 4:
                accountList = SystemRepo.instance().readAccountsFromFile()
                joint()
                break
            default:
                print("Please choose valid option")
                break
            }
        }
    }
    
    func accountNumber() -> Int64 {
        if (lastCustomerNum == 0) {
            lastCustomerNum = 100000000
        } else {
            lastCustomerNum = lastCustomerNum + 1
        }
        return lastCustomerNum
    }
    
    //for saving account
    func savings() {
        print("Enter the Customer no: ")
        let customerNo = Int64(readLine()!)!
        print("Enter  amount for opening account: ")
        let openingBalance = Double(readLine()!)!
        print("Enter annual interest: ")
        let annualInterest = Double(readLine()!)!
        let num = accountNumber()
        let obj = Savings(accountNo: num, createdDate: getCurrentShortDate(), customerNo: customerNo, balance: openingBalance, openingBalance: openingBalance, annualInterest: annualInterest)
        accountList.append(obj)
        preference.accountNum = lastCustomerNum
        print("Account Id is:" + "\(num)")
        SystemRepo.instance().saveAccountsInFile(accounts: accountList)
    }
    
    //for current
    func current() {
        print("Enter the Customer no: ")
        let customerNo = Int64(readLine()!)!
        print("Enter opening balance: ")
        let openingBalance = Double(readLine()!)!
        let createdDate = getCurrentShortDate()
        let num = accountNumber()
        let obj = Current(accountNo: num, createdDate: createdDate, customerNo: customerNo, balance: openingBalance, openingBalance: openingBalance)
        accountList.append(obj)
        preference.accountNum = lastCustomerNum
        print("Account Id is:" + "\(num)")
        SystemRepo.instance().saveAccountsInFile(accounts: accountList)
    }
    
    //for fixeddeposit account
    func fixeddeposit() {
        let createdDate = getCurrentShortDate()
        print("Enter the Customer no: ")
        let customerNo = Int64(readLine()!)!
        print("Enter the amount:")
        let noOfDeposit = Double(readLine()!)!
        print("interest rate:")
        let interestRate = Double(readLine()!)!
        print("Enter Time period (in months): ")
        let time = Double(readLine()!)!
        let num = accountNumber()
        let obj = Fixeddeposit(accountNo: num, createdDate: createdDate, customerNo: customerNo, balance: noOfDeposit, depositAmount: noOfDeposit, interestRate: interestRate, timePeriod: time)
        accountList.append(obj)
        preference.accountNum = lastCustomerNum
        print("Account Id is:" + "\(num)")
        SystemRepo.instance().saveAccountsInFile(accounts: accountList)
    }
    
    //for joint account
    func joint() {
        let createdDate = getCurrentShortDate()
        print("Enter the Customer no: ")
        let customerNo = Int64(readLine()!)!
        print("Enter opening balance:");
        let openingBalance = Double(readLine()!)!
        print("Enter the name of joint account holder")
        let jointHolderName = readLine()!
        print("Enter relationship with joint account holder")
        let holderRelationship = readLine()!
        let num = accountNumber()
        let obj = Joint(accountNo: num, createdDate: createdDate, customerNo: customerNo, balance: openingBalance, openingBalance: openingBalance, jointHolderName: jointHolderName, holderRelationship: holderRelationship)
        accountList.append(obj)
        preference.accountNum = lastCustomerNum
        print("Account Id is:" + "\(num)")
        SystemRepo.instance().saveAccountsInFile(accounts: accountList)
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate)
        return DateInFormat
    }
    
}
