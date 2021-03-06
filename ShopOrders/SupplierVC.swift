//
//  Supplier.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

//import CoreData
import Realm
import SwiftForms
import UIKit


extension String {
    var length: Int { return count(self)         }  // Swift 1.2
}

class SupplierVC: FormViewController {
    
    var supplier : Supplier?
    
    struct Static {
        static let nameTag = "name"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let segmented = "segmented"
        static let picker = "picker"
        static let button = "button"
    }
    
    required init(coder aDecoder: NSCoder) {
//        self.supplier = Supplier()

        super.init(coder: aDecoder)
        self.supplier = nil
        
        self.loadForm()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        println("me llego \(self.supplier)")

        loadForm()
        
        println(RLMRealm.defaultRealm().path)

        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "submit:")
        
        
    }
    
    
 
    
    private func loadForm() {
        let form = FormDescriptor()
        
        form.title = "Supplier"
        
        
        println("tha supplier ::  \(supplier)")
        
        let section5 = FormSectionDescriptor()
        
        var row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "Name")
  
        
        if(supplier != nil){
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.text" : supplier!.name, "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)
            
            row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.text" : supplier!.email, "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)
            
            
            row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.text" : supplier!.phone, "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)
 
        }else {
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Supplier Name", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)
            
            row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "john@gmail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)
            
            
            row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            section5.addRow(row)

        }
        
        
        //
        
        row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Cut Off Day")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "MO":
                return "Monday"
            case "TU":
                return "Tuesday"
            case "WE":
                return "Wednesday"
            case "TH":
                return "Thursday"
            case "FR":
                return "Friday"
            case "SA":
                return "Saturday"
            case "SU":
                return "Sunday"
            default:
                return nil
            }
            } as TitleFormatterClosure
        
        row.value = "M"
        
        section5.addRow(row)
        //
        
        var productsString = "Products"
        
        //products button


        if(supplier != nil){
            let numberOfroducts:UInt = supplier!.products.count
            productsString = "\(numberOfroducts) Products"
        }
        
        row = FormRowDescriptor(tag: Static.button, rowType: .Button, title: productsString)
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            self.view.endEditing(true)

            //check if empty, non if, so,
            
            if(self.supplier == nil){
                let name = self.form.formValues()["name"] as? String
                let email = self.form.formValues()["email"] as? String
                let phone = self.form.formValues()["phone"] as? String
                if(self.isValid(name, email:email, phone:phone)) {
                    let predicate = NSPredicate(format: "name BEGINSWITH [c]%@", name!)
                    let saba = Supplier.objectsWithPredicate(predicate)
                    let realm = RLMRealm.defaultRealm()
                     
                    if(saba.count == 0){
                        let supplierInserto = Supplier()
                        supplierInserto.name = name!
                        supplierInserto.email = email!
                        supplierInserto.phone = phone!
//                        supplierInserto.product =  [ProductsDao()]
                        
                        realm.transactionWithBlock(){
                            realm.addObject(supplierInserto)
                        }
                        self.supplier = supplierInserto
                        
                    }else{
                        let supplierObj : Supplier = saba[0] as! Supplier
                        realm.beginWriteTransaction()
                        supplierObj.name = name!
                        supplierObj.email = email!
                        supplierObj.phone = phone!
                        realm.commitWriteTransaction()
                        self.supplier = supplierObj
                    }
                    self.performSegueWithIdentifier("showProducts", sender: nil)
                }
            }else{
                self.performSegueWithIdentifier("showProducts", sender: nil)

            }

            //segue
            
            } as DidSelectClosure
        
        section5.addRow(row)
        
        section5.headerTitle = "Details"
        
        
        
        form.sections = [section5]

        self.form = form
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let productsVC = segue.destinationViewController as? Products {
            productsVC.supplier = self.supplier
        }
        
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
 
        let alert = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        alert.show()
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
 
}
