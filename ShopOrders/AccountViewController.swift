//
//  AccountViewController.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 4/09/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import SwiftForms
import UIKit

class AccountViewController: FormViewController {

    struct Static {
        static let nameTag = "name"
        static let emailTag = "email"
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
        
        let section1 = FormSectionDescriptor()
        
        
        section1.headerTitle = "Account Details"

        var row: FormRowDescriptor! = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "Shop Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "my Awesome shop", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "Address")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "my Awesome shop", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "awesome@myshop.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "Contact name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "person in charge", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "ABN")
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
            self.view.endEditing(true)
            self .dismissViewControllerAnimated(true, completion: nil)
            
            } as DidSelectClosure
        section8.addRow(row)
        
        form.sections = [section1, section5, section7, section8]
        
        section8.footerTitle = "MyOrders by GizmoMen"
        
        self.form = form
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)

        
    }}
