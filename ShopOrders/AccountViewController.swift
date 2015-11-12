//
//  AccountViewController.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 4/09/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Alamofire
import Realm 
import SwiftForms
import UIKit

class AccountViewController: FormViewController {

    
    
    struct Static {
        static let shopNameTag = "shopName"
        static let shopAddressTag = "shopAddress"
        static let contactNameTag = "contactName"
        static let emailTag = "email"
        static let abnTag = "abn"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let openingTime = "openingTime"
        static let closingTime = "closingTime"
        static let button = "button"
        static let stepper = "stepper"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
    }
    
    /// MARK: Actions
    
    func submit(UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        
        //        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        
        let alert = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        alert.show()
    }
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Example Form"
        
        


        var row: FormRowDescriptor! = FormRowDescriptor(tag: Static.shopNameTag, rowType: .Name, title: "Shop Name")
        
        let section1 = FormSectionDescriptor()
        section1.headerTitle = "Account Details"
        
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. My Awesome shop", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.shopAddressTag, rowType: .Name, title: "Address")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 43 Main st", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "awesome@myshop.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.contactNameTag, rowType: .Name, title: "Contact name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "person in charge", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.abnTag, rowType: .Phone, title: "ABN")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "ABN #", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.URLTag, rowType: .URL, title: "URL")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. gizmomen.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section1.addRow(row)
    
        
        
        let section5 = FormSectionDescriptor()
        section5.headerTitle = "Opening hours"

        row = FormRowDescriptor(tag: Static.openingTime, rowType: .Time, title: "Opening time")
        section5.addRow(row)
        
        row = FormRowDescriptor(tag: Static.closingTime, rowType: .Time, title: "Closing time")
        section5.addRow(row)
        
        let section7 = FormSectionDescriptor()
        section7.headerTitle = "Delivery Instructions"
        row = FormRowDescriptor(tag: Static.textView, rowType: .MultilineText, title: "Instructions")
        section7.addRow(row)
        
        let section8 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.button, rowType: .Button, title: "Save")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            self.saveButtonPressed()
            
            } as DidSelectClosure
        section8.addRow(row)
        
        form.sections = [section1, section5, section7, section8]
        
        section8.footerTitle = "MyOrders by GizmoMen"
        
        self.form = form
    }
    
    func saveButtonPressed(){
        //validate
        if (formIsValid()){
            //save entity account
            let realm = RLMRealm.defaultRealm()
            let accountInserto = AccountDAO()
            
            if let shusa:String = self.form.formValues() ["shopName"] as? String{
                accountInserto.shopName = shusa
            }
            if let shusa:String = self.form.formValues() ["shopAddress"] as? String{
                accountInserto.address = shusa
            }
            if let shusa:String = self.form.formValues() ["phone"] as? String{
                accountInserto.phone = shusa
            }
            if let shusa:String = self.form.formValues() ["email"] as? String{
                accountInserto.email = shusa
            }
            if let shusa:String = self.form.formValues() ["contactName"] as? String{
                accountInserto.contactName = shusa
            }
            if let shusa:String = self.form.formValues() ["abn"] as? String{
                accountInserto.abn = shusa
            }
            if let shusa:String = self.form.formValues() ["abn"] as? String{
                accountInserto.url = shusa
            }
            if let shusa:String = self.form.formValues() ["openingTime"] as? String{
                accountInserto.openingTime = shusa
            }
            if let shusa:String = self.form.formValues() ["closingTime"] as? String{
                accountInserto.closingTime = shusa
            }
            if let shusa:String = self.form.formValues() ["instructions"] as? String{
                accountInsertoq 
            
        }
        self.view.endEditing(true)
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postForm(AccountDAO){
        
        let parameters = [
            "name": "user1",
            "username": "user1",
            "password": "password1",
            "shopName": "shopa",
            "address": "23 sh",
            "phone": "2323",
            "email": "ju@ja.net",
            "contactName": "julious",
            "ABN": "2323",
            "URL": "2323",
            "openingTime": "12",
            "closingTime": "23",
            "instructions": "never take the garbage out the front"
        ]
        
 
        
        Alamofire.request(.POST, "http://ordering.gizmomen.com/api/users/", parameters: parameters, encoding: .JSON)
        // HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}

    }
    
    func formIsValid()->Bool{
//        let message = self.form.formValues().description
        if(!analizeFormField("shopName", value: "shop")){
            return false
        }
        if(!analizeFormField("email", value: "email")){
            return false
        }
        if(!analizeFormField("email", value: "email")){
            return false
        }
        return true
    }
    
    func analizeFormField(key:String, value:String)->Bool{
//        println("se :: \(form.formValues().description)")
        if let shopa: String = self.form.formValues() [key] as? String{
            //fprintln("nombre :: \(shopa)")
            
        }else{
            showAlert("MyOrders", message: "Please enter \(value) Name")
            return false
        }
        
        return true;
    }
    
    func showAlert(title:String, message:String){
        var altMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        altMessage.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(altMessage, animated: true, completion: nil)
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
