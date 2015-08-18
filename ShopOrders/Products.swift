//
//  Products.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Realm
import UIKit

class Products: UITableViewController {

    var supplier : Supplier?
    

    
    override func viewDidLoad() {
        
        self.title = "\(supplier!.name) Products"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .Plain, target: self, action: "newBPressed:")
        
        println("tu int, :: \(supplier!)")
    }
    
    
    func newBPressed(UIBarButtonItem!){

        let actionSheetController: UIAlertController = UIAlertController(title: "New Product", message: "Please type product info", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
            println("canchela")
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .Default) { action -> Void in
            //Do some other stuff
            println(actionSheetController.textFields?.first)
            
            let textField0 = actionSheetController.textFields? [0] as? UITextField
            
            let textField1 = actionSheetController.textFields? [1] as? UITextField
            
            println(textField0!.text)
            println(textField1!.text)

            self.isValid(textField0!.text, reference: textField1!.text)
            
            //crea producto!
            let productInserto = ProductsDao()
            productInserto.name = textField0!.text
            
            if((textField1!.text) != nil){
                productInserto.ref = textField1!.text
            }
            
            
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            // Find objects
//            var localTypes = FormTypeLocal.objectsWhere("formname = \(formname)")
//            // Update one of those objects
//            var existingForm = localTypes[0] as FormTypeLocal
//            existingForm.customProp = "newVal"

            self.supplier?.product = productInserto
            // Wrap up transaction
            realm.commitWriteTransaction()
            
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
//            textField.textColor = UIColor.blueColor()
            textField.placeholder = "Product Name"

        }
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.placeholder = "Reference"
        }
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
     
    }
    
    func isValid(name:String?, reference:String?) -> Bool {
        if((name) == nil){
            showAlert("MyOrders", message: "please enter product name")
            return false
        }

        return true
    }
    
    func showAlert(title:String, message:String){
        var altMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        altMessage.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(altMessage, animated: true, completion: nil)
    }
    
}
