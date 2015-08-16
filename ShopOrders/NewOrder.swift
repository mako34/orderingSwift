//
//  NewOrder.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 15/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import UIKit
import SwiftForms

class NewOrder: FormViewController {

    struct Static {
        static let picker = "picker"
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
        
        form.title = "Supplier"
        
        
        let section5 = FormSectionDescriptor()
        
        var row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Gender")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["F", "M", "U"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "F":
                return "Female"
            case "M":
                return "Male"
            case "U":
                return "I'd rather not to say"
            default:
                return nil
            }
            } as TitleFormatterClosure
        
        row.value = "M"
        
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
