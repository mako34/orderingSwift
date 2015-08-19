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
    var products : RLMArray?
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        
        self.title = "\(supplier!.name) Products"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .Plain, target: self, action: "newBPressed:")

        println("transaction prods:: \(supplier?.products)")
        
        products = supplier?.products
        
        table.reloadData()
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
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            
            let productInserto = ProductsDao()
            productInserto.name = textField0!.text
            
            if((textField1!.text) != nil){
                productInserto.ref = textField1!.text
            }
            
            
            self.supplier?.products .addObject(productInserto)
            
            realm.addObject(productInserto)

            // Find objects
//            var localTypes = FormTypeLocal.objectsWhere("formname = \(formname)")
//            // Update one of those objects
//            var existingForm = localTypes[0] as FormTypeLocal
//            existingForm.customProp = "newVal"

//            self.supplier?.product = productInserto
            // Wrap up transaction
            realm.commitWriteTransaction()
            
            //get supplier again
            
            let predicate = NSPredicate(format: "name BEGINSWITH [c]%@", self.supplier!.name)
            let saba = Supplier.objectsWithPredicate(predicate)
            
            println("lista  :: \(saba)")
            
//            ProductsDao.objectsWithPredicate(<#predicate: NSPredicate?#>)
            
            println(ProductsDao.allObjects())
            
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
    
    //table stuff
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Int(self.products!.count)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellProducts")

        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellProducts", forIndexPath: indexPath) as! UITableViewCell
        
         

 
        // Configure the cell...
        
        
        let index = UInt(indexPath.row)
        let prodItem = self.products!.objectAtIndex(index) as! ProductsDao
        
        cell.textLabel?.text = prodItem.name
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
//        
//        let index = UInt(indexPath.row)
//        let supplierItem = self.suppliers.objectAtIndex(index) as! Supplier
//        
//        self.supplier = self.suppliers.objectAtIndex(index) as! Supplier
//        
//        
//        println("selecto \(supplierItem)")
//        
//        self.performSegueWithIdentifier("showSupplier", sender: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//            //alert n delete!
//            let realm = RLMRealm.defaultRealm() //1
//            let objectToDelete = self.suppliers[UInt(indexPath.row)] as! Supplier //2
//            realm.beginWriteTransaction() //3
//            realm.deleteObject(objectToDelete) //4
//            realm.commitWriteTransaction() //5
//            
//            self.suppliers = Supplier.allObjects()
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //7
//            
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
    }

    
}
