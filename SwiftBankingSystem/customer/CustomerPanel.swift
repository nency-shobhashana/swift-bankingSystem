//  CustomerPanel.swift
//  SwiftBankingSystem

import Foundation

class CustomerPanel{
    let preference = UserDefaultManager.shared
    var customers = [Customer]()
    var lastCustomerNum : Int64
    let directoryURL: URL
    let fileURL: URL
    
    init() {
        lastCustomerNum = preference.customerNum ?? 0
        directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = URL(fileURLWithPath: "CustomerData", relativeTo: directoryURL).appendingPathExtension("txt")
    }
    
    // initial option method
    func main() {
        print("\n Customer Panel\n")
        customers = [Customer]()
        readingFromFile()
        while(true) {
            print("1.Create Customer\n2.View/Update Customer")
            let choice = Int(readLine()!)!
            switch choice {
            case 1:
                filling()
                savingData()
            case 2:
                viewOrUpdateCustomer()
            default:
                break
            }
            print("Do you want to continue? y/n")
            let answer = readLine()!
            if answer == "n" {
                break
            }
        }
    }
    
    // get latest customer number
    func customerNumber() -> Int64 {
        if (lastCustomerNum == 0) {
            lastCustomerNum = 100000000
        } else {
            lastCustomerNum = lastCustomerNum + 1
        }
        return lastCustomerNum
    }
    
    // function to read from file
    func readingFromFile(){
        do {
            let savedData = try Data(contentsOf: fileURL)
            if String(data: savedData, encoding: .utf8) != nil {
                let data = String(decoding: savedData, as: UTF8.self)
                let lines = data.components(separatedBy: "\n")
                for line in lines {
                    let fields = line.components(separatedBy: ",")
                    if Int(fields[0]) != nil {
                        let cust = Customer(no: Int64(fields[0])!, name: fields[1], address: fields[2], gender: fields[3], phone: fields[4], email: fields[5], dob: fields[6])
                        customers.append(cust)
                        
                    }
                }
            }
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }
    }
    
    // reading from keyboard and fill the customer array
    func filling(){
        print("Enter customer name")
        let name = readLine()!
        print("Enter customer address:")
        let address = readLine()!
        print("Enter customer gender:")
        let gender = readLine()!
        print("Enter customer phone:")
        let phone = readLine()!
        print("Enter customer email:")
        let email = readLine()!
        print("Enter customer DOB:")
        let dob = readLine()!
        let num = customerNumber()
        let obj = Customer(no: num, name: name, address: address, gender: gender, phone: phone, email: email, dob: dob)
        customers.append(obj)
        preference.customerNum = lastCustomerNum
        print("Customer is created successfully. Customber No is:" + "\(num)")
    }
    
    // function to save data to a file
    func savingData() {
        
        var myString:String = ""
        for customer in customers {
            myString += customer.fileFormat()
        }
        
        let data = myString.data(using: .utf8)
        do {
            
            try data?.write(to: fileURL)
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    // function to view or update customer
    func viewOrUpdateCustomer() {
        print("Choose \n1: View\n2: Update");
        let choice = Int(readLine()!)!
        if (choice == 1) {
            print("Enter the customer number: ")
            let num = Int(readLine()!)!
            for cust in customers {
                if cust.customerNo == num {
                    cust.printCustomer()
                }
            }
        } else if (choice == 2) {
            print("Enter the customer number: ");
            let num = Int(readLine()!)!
            print("Choose from below options: \n1: Change name\n2: Change address\n3: Change Phone number\n4: Change email")
            let select = Int(readLine()!)!
            switch (select) {
            case 1:
                print("Enter the new name: ")
                let name2 = readLine()!
                updateCustomer(num: num, new: name2, option: 1)
                break;
            case 2:
                print("Enter the new address: ")
                let address2 = readLine()!
                updateCustomer(num: num, new: address2, option: 2)
                break;
            case 3:
                print("Enter the new phone number: ")
                let phone2 = readLine()!
                updateCustomer(num: num, new: phone2, option: 3)
                break;
            case 4:
                print("Enter the new email: ")
                let email2 = readLine()!
                updateCustomer(num: num, new: email2, option: 4)
                break;
            default:
                break;
            }
        }
    }
    
    // update customer data
    func updateCustomer(num:Int, new:String, option: Int) {
        let customer = searchByNum(no: num)
        if option == 1 {
            customer?.customerName = new
        } else if option == 2 {
            customer?.customerAddress = new
        } else if option == 3 {
            customer?.customerPhone = new
        } else if option == 4{
            customer?.customerEmail = new
        }
        savingDataToCustomer()
    }
    
    // search customer
    func searchByNum(no:Int) -> Customer? {
        for cust in customers {
            if cust.customerNo == no {
                return cust
            }
        }
        return nil
    }
    
    // function to save data to customer file
    func savingDataToCustomer() {
        var myString:String = ""
        for cust in customers {
            myString += cust.fileFormat()
        }
        
        let data = myString.data(using: .utf8)
        do {
            
            try data?.write(to: fileURL)
            print("Customer data is updated")
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
}
