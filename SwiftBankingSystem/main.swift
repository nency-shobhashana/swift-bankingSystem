//  main.swift
//  SwiftBankingSystem

import Foundation

func main() {
    let transactionPanel = TransactionPanel()
    let accountPanel = AccountPanel()
    let customerPanel = CustomerPanel()
    print()
    print("Welcome to Banking System")
    print()
    
    while (true) {
        print("Choose from below for banking:")
        print("1. Create/View or Update Customer")
        print("2. Create Account")
        print("3. Do Transactions")
        print("0. Exit")
        let type = Int(readLine()!)!
        switch (type) {
        case 0: return
        case 1: customerPanel.main()
        case 2: accountPanel.main()
        case 3: transactionPanel.main()
        default : print("Please choose valid option")
        }
    }
}

main()
