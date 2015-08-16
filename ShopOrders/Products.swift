//
//  Products.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import UIKit

class Products: UITableViewController {

    override func viewDidLoad() {
        
        self.title = "Products"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .Plain, target: self, action: "newBPressed:")
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
        
        //way1
        
//        var altMessage = UIAlertController(title: "Warning", message: "This is Alert Message", preferredStyle: UIAlertControllerStyle.Alert)
//        altMessage.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(altMessage, animated: true, completion: nil)
    
        
        
        
    // way 2
//        var alertController = UIAlertController(title: "New Product", message: "Please enter", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        let actionCancle = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { ACTION in
//            
//        }
//
//        
//        alertController.addAction(actionCancle)
//        alertController.addTextFieldWithConfigurationHandler({(txtField: UITextField!) in
//            txtField.placeholder = "Product Name"
//            txtField.keyboardType = UIKeyboardType.NumberPad
//        })
//        
//        
//        
//        alertController.addTextFieldWithConfigurationHandler({(txtField: UITextField!) in
//            txtField.placeholder = "Reference"
//            txtField.keyboardType = UIKeyboardType.NumberPad
//        })
//        presentViewController(alertController, animated: true, completion: nil)
//    
//        alertController.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default,handler: {
//            
//            (alert: UIAlertAction!) in
//            if let textField = alertController.textFields?.first as? UITextField{
//                println(textField.text)
//            }
//            
//            var arraya = alertController.textFields
//            
//            
//        }))
//    
    }
    
    
    
}
