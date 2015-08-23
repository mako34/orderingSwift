//
//  NewOrder.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 15/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Realm
import UIKit

class NewOrder: UIViewController{

    var order : OrderDao?
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderName: UITextField!
    @IBOutlet weak var itemsOrdered: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        self.title = "New Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Product", style: .Plain, target: self, action: "addProduct:")
    
        println("entro : \(order)")
        
        //populate
        orderDate.text = shortDate(order!.date)
        orderName.text = order?.name
        itemsOrdered.text = String(stringInterpolationSegment: order!.productsOrdered.count)
    
        tableView .reloadData()
        
    } 
    
    func shortDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.stringFromDate(date)
    }
    
    func addProduct(UIBarButtonItem!){
    
        if(orderName.text.length == 0){
            showAlert("MyOrders", message: "Please enter order name")
            
            
        }else {
            
            let realm = RLMRealm.defaultRealm()
            
            let orderInserto = OrderDao()
            orderInserto.name = orderName.text
            order = orderInserto
            realm.transactionWithBlock(){
                realm.addObject(orderInserto)
            }
            
            self.performSegueWithIdentifier("presentModalNewProduct", sender: nil)

        }

        
    }
    
    func showAlert(title:String, message:String){
        var altMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        altMessage.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(altMessage, animated: true, completion: nil)
    }
    
    
    //table stuff
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Int(order!.productsOrdered.count)
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        footerView.backgroundColor = UIColor.lightGrayColor()
        
        return footerView
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellProducts")
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellProducts", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        let index = UInt(indexPath.row)
        let prodItem = order?.productsOrdered.objectAtIndex(index) as! ProductOrderedDao
        
        cell.textLabel?.text = prodItem.name
        
        return cell
    }
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let productsVC = segue.destinationViewController as? ChooseProduct {
            productsVC.order = order
        }
        
    }
    
    
    
}
