//
//  Supplier.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import UIKit
import SwiftForms

class Supplier: FormViewController {
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
        
    }
    
    private func loadForm() {
        let form = FormDescriptor()
        
        form.title = "New Order"
        
        
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
//            self.view.endEditing(true)

            //segue
            self.performSegueWithIdentifier("showProducts", sender: nil)
            
            } as DidSelectClosure
        section5.addRow(row)
        
        section5.headerTitle = "Date of order"
        
        
        
        form.sections = [section5]

        self.form = form
    }
    
    
    func submit(UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        
        //        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        
        let alert = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OKs")
        
        alert.show()
    }
}
