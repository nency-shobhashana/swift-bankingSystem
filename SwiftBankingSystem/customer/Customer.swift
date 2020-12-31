//  Customer.swift
//  SwiftBankingSystem

import Foundation

class Customer {
    
    var customerNo:Int64
    var customerName:String
    var customerAddress:String
    var customerGender:String
    var customerPhone:String
    var customerEmail:String
    var customerDOB:String
    
    init(no:Int64, name:String, address:String, gender:String, phone:String, email:String, dob:String) {
        self.customerName = name
        self.customerAddress = address
        self.customerGender = gender
        self.customerPhone = phone
        self.customerEmail = email
        self.customerDOB = dob
        self.customerNo = no
    }
    
    func fileFormat() ->String {
        let singleline = String(self.customerNo)+","+self.customerName+","+self.customerAddress+","+self.customerGender+","+self.customerPhone+","+self.customerEmail+","+self.customerDOB+"\n"
        return singleline
    }
    
    func printCustomer() {
        print("Customer No: \(self.customerNo)\nCustomer Name: \(self.customerName)\nCustomer Address: \(self.customerAddress)\nCustomer Gender: \(self.customerGender)\nCustomer Phone: \(self.customerPhone)\nCustomer Email: \(self.customerEmail)\nCustomer DOB: \(self.customerDOB)")
    }
    
}
