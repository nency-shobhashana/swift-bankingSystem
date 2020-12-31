//  SystemRepo.swift
//  SwiftBankingSystem

import Foundation

class SystemRepo {
    
    //singleton
    private static var sharedSystemRepo: SystemRepo = {
        let systemRepo = SystemRepo()
        return systemRepo
    }()
    
    class func instance() -> SystemRepo {
        return sharedSystemRepo
    }
    
    //defining the location of the file
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    //defining the file by its name and txt as extension
    let transactionFileName: URL
    let accountFileName: URL
    
    init() {
        transactionFileName = URL(fileURLWithPath: "transaction", relativeTo: directoryURL).appendingPathExtension("txt")
        accountFileName = URL(fileURLWithPath: "account", relativeTo: directoryURL).appendingPathExtension("txt")
    }
    
    // saving transaction array in to file
    func saveTransactionsInFile(transactions: [BaseTransaction]) -> Bool {
        //merging all lines form the array in one string
        var myString:String = ""
        for tran in transactions{
            myString += tran.toString() + "\n"
        }
        //convert from string to data
        let data = myString.data(using: .utf8)
        do {
            //write the data into the file
            try data?.write(to: transactionFileName)
            return true
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
        return false
    }
    
    //get the transaction from the file
    func readTransactionsFromFile() -> [BaseTransaction] {
        var transactions = [BaseTransaction]()
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: transactionFileName)
            // Convert the data back into a string
            if String(data: savedData, encoding: .utf8) != nil {
                let data = String(decoding: savedData, as: UTF8.self)
                let lines = data.split(whereSeparator: \.isNewline)
                for line in lines{
                    //split each line into words which are fields
                    var transaction: BaseTransaction? = nil
                    let transactionType = line.split(separator: " ")[0]
                    //create an object of Product assuming the seprated words are the inputs
                    if (transactionType == "Deposit") {
                        transaction = Deposit.parseDeposit(str: String(line))
                    }
                    if (transactionType == "Withdraw") {
                        transaction = Withdraw.parseWithdraw(str: String(line))
                    }
                    if (transactionType == "Transfer") {
                        transaction = Transfer.parseTransfer(str: String(line))
                    }
                    if (transactionType == "BillPayment") {
                        transaction = BillPayment.parseBillPayment(str: String(line))
                    }
                    if (transactionType == "MobilePayment") {
                        transaction = MobilePayment.parseMobilePayment(str: String(line))
                    }
                    if(transaction != nil){
                        transactions.append(transaction!)
                    }
                }
            }
        } catch {
            print("Unable to read the file")
        }
        return transactions
    }
    
    // save accounts array in file
    func saveAccountsInFile(accounts: [Account]) -> Bool{
        //merging all lines form the array in one string
        var myString:String = ""
        for acc in accounts{
            myString += acc.toString() + "\n"
        }
        //convert from string to data
        let data = myString.data(using: .utf8)
        do {
            //write the data into the file
            try data?.write(to: accountFileName)
            return true
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
        return false
    }
    
    //get accounts array from file
    func readAccountsFromFile() -> [Account] {
        var accounts = [Account]()
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: accountFileName)
            // Convert the data back into a string
            if String(data: savedData, encoding: .utf8) != nil {
                let data = String(decoding: savedData, as: UTF8.self)
                let lines = data.split(whereSeparator: \.isNewline)
                for line in lines{
                    //split each line into words which are fields
                    var account: Account? = nil
                    let accountType = line.split(separator: " ")[0]
                    //create an object of Product assuming the seprated words are the inputs
                    if (accountType == "Current") {
                        account = Current.parseCurrent(str: String(line))
                    }
                    if (accountType == "Fixeddeposit") {
                        account = Fixeddeposit.parseFixeddeposit(str: String(line))
                    }
                    if (accountType == "Joint") {
                        account = Joint.parseJoint(str: String(line))
                    }
                    if (accountType == "Savings") {
                        account = Savings.parseSavings(str: String(line))
                    }
                    if(account != nil){
                        accounts.append(account!)
                    }
                }
            }
        } catch {
            print("Unable to read the file")
        }
        return accounts
    }
    
    // get account object based on account no
    func getAccount(accountNo: Int64) -> Account? {
        let data = readAccountsFromFile()
        let account =  data.first { (account) -> Bool in
            account.accountNo == accountNo
        }
        return account
    }
    
    // update account info and save it in file
    func updateAccount(account: Account){
        var accounts = readAccountsFromFile()
        let index = accounts.firstIndex { (acc) -> Bool in
            acc.accountNo == account.accountNo
        }
        accounts[index!] = account
        saveAccountsInFile(accounts: accounts)
    }
    
    // get last transaction id from file
    func lastTransId() -> Int64 {
        return readTransactionsFromFile().last?.accountNo ?? 0
    }
    
    // get last ten transactions of given account no
    func lastTenTransaction(accountNo: Int64) -> [BaseTransaction] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction.accountNo == accountNo
        }.suffix(10)
    }
    
    // get last ten deposit transactions
    func lastTenDepositTransaction() -> [Deposit] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction is Deposit
        }.suffix(10).map { (baseTran) -> Deposit in
            baseTran as! Deposit
        }
    }
    
    // get last ten withdraw transactions
    func lastTenWithdrawTransaction() -> [Withdraw] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction is Withdraw
        }.suffix(10).map { (baseTran) -> Withdraw in
            baseTran as! Withdraw
        }
    }
    
    // get last ten transfer transacions
    func lastTenTransferTransaction() -> [Transfer] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction is Transfer
        }.suffix(10).map { (baseTran) -> Transfer in
            baseTran as! Transfer
        }
    }
    
    //get last ten bill payment transctions
    func lastTenBillPaymentTransaction() -> [BillPayment] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction is BillPayment
        }.suffix(10).map { (baseTran) -> BillPayment in
            baseTran as! BillPayment
        }
    }
    
    // get last ten mobile payment transactions
    func lastTenMobilePaymentTransaction() -> [MobilePayment] {
        return readTransactionsFromFile().filter { (baseTransaction) -> Bool in
            baseTransaction is MobilePayment
        }.suffix(10).map { (baseTran) -> MobilePayment in
            baseTran as! MobilePayment
        }
    }
    
    // insert deposit transaction into file
    func depositTransaction(deposit: Deposit) -> Int64 {
        var transactions = readTransactionsFromFile()
        transactions.append(deposit)
        if(saveTransactionsInFile(transactions: transactions)){
            return deposit.tranID
        }
        else {
            return -1
        }
    }
    
    // insert withdraw transaction into file
    func withdrawTransaction(withdraw: Withdraw) -> Int64 {
        var transactions = readTransactionsFromFile()
        transactions.append(withdraw)
        if(saveTransactionsInFile(transactions: transactions)){
            return withdraw.tranID
        }
        else {
            return -1
        }
    }
    
    // insert transfer transaction into file
    func transferTransaction(transfer : Transfer) -> Int64 {
        var transactions = readTransactionsFromFile()
        transactions.append(transfer)
        if(saveTransactionsInFile(transactions: transactions)){
            return transfer.tranID
        }
        else {
            return -1
        }
    }
    
    // insert bill payment transaction into file
    func billPaymentTransaction(billPayment: BillPayment) -> Int64 {
        var transactions = readTransactionsFromFile()
        transactions.append(billPayment)
        if(saveTransactionsInFile(transactions: transactions)){
            return billPayment.tranID
        }
        else {
            return -1
        }
    }
    
    // insert mobile payment transaction into file
    func mobilePaymentTransaction(mobilePayment: MobilePayment) -> Int64 {
        var transactions = readTransactionsFromFile()
        transactions.append(mobilePayment)
        if(saveTransactionsInFile(transactions: transactions)){
            return mobilePayment.tranID
        }
        else {
            return -1
        }
    }
}
