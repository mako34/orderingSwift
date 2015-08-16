//
//  Supplier.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import CoreData
import UIKit
import SwiftForms
 

class SupplierVC: FormViewController {
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let button = "button"
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "submit:")
        
    }
    
    private func loadForm() {
        let form = FormDescriptor()
        
        form.title = "Supplier"
        
        
        let section5 = FormSectionDescriptor()
        
        var row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Supplier Name", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section5.addRow(row)
        
        row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "john@gmail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section5.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section5.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.button, rowType: .Button, title: "Products")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            self.view.endEditing(true)

            //check if empty, non if, so,

            let name = self.form.formValues()["name"] as? String
            let email = self.form.formValues()["email"] as? String
            let phone = self.form.formValues()["phone"] as? String

            println(self.form.formValues()["email"])

            //why self?
            
            if(self.isValid(name, email:email, phone:phone)) {
                println("continue with elements ::")
                
                let supps = Supplier.MR_findAll()
                println(supps)
                
                //check if exist
                let predicate = NSPredicate(format: "name = %@", name!)
                var supplierObj = Supplier.MR_findFirstWithPredicate(predicate) as? Supplier
                
                if(supplierObj == nil){
                    supplierObj = (Supplier.MR_createEntity() as! Supplier)
                }
  
                supplierObj?.name = name!
                supplierObj?.email = email!
                supplierObj?.phone = phone!
//                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                
                 
                self.performSegueWithIdentifier("showProducts", sender: nil)
            }
            
            //segue
            
            } as DidSelectClosure
        section5.addRow(row)
        
        section5.headerTitle = "Details"
        
        
        
        form.sections = [section5]

        self.form = form
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func isValid(name:String?, email:String?, phone:String?) -> Bool {
 
        
        if ((name) == nil){
            showAlert("MyOrders", message: "Please enter business name")
            return false;
        }
        if ((email) == nil){
            showAlert("MyOrders", message: "Please enter email")
            return false;
        }else if (!isValidEmail(email!)){
            showAlert("MyOrders", message: "Please enter valid email")
            return false;
        }
        if ((phone) == nil){
            showAlert("MyOrders", message: "Please enter phone number")
            return false;
        }

   
        
        return true
    }
    
    func showAlert(title:String, message:String){
        var altMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        altMessage.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(altMessage, animated: true, completion: nil)
    }
    
    func theSupplier(){
        
    }
    
    func submit(UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        
        //        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        
        let alert = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        alert.show()
    }
}