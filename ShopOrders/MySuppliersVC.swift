//
//  MySuppliersVC.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import UIKit
import Realm

class MySuppliersVC: UITableViewController {

    var supplier : Supplier?


    
    @IBOutlet var table: UITableView!
    var suppliers : RLMResults!
//    var suppliers = RLMArray(objectClassName: Supplier.className())

//    
//    required init(coder aDecoder: NSCoder) {
//        self.supplier = Supplier()
//        
//        super.init(coder: aDecoder)
//        
//        
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        

        
//        suppliers = Supplier.MR_findAllSortedBy("name", ascending: true) as! [Supplier]
        
        var supplieres : RLMResults {
            get {
                return Supplier.allObjects()
            }
        }
 
        self.suppliers = supplieres
        
        
        println(supplieres)
        
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Int(self.suppliers.count)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...


        let index = UInt(indexPath.row)
        let supplierItem = self.suppliers.objectAtIndex(index) as! Supplier
        
        cell.textLabel?.text = supplierItem.name
        
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        let index = UInt(indexPath.row)
        let supplierItem = self.suppliers.objectAtIndex(index) as! Supplier
        
        self.supplier = self.suppliers.objectAtIndex(index) as! Supplier
        
        
        println("selecto \(supplierItem)")
        
        self.performSegueWithIdentifier("showSupplier", sender: nil)
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
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //alert n delete!
            let realm = RLMRealm.defaultRealm() //1
            let objectToDelete = self.suppliers[UInt(indexPath.row)] as! Supplier //2
            realm.beginWriteTransaction() //3
            realm.deleteObject(objectToDelete) //4
            realm.commitWriteTransaction() //5
            
            self.suppliers = Supplier.allObjects()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //7
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let supplierVC = segue.destinationViewController as? SupplierVC
        
        println("tu sup \(self.supplier)")
        
        supplierVC!.supplier = self.supplier

        
        //        if let supplierVC = segue.destinationViewController as? SupplierVC {
//            println(self.supplier)
//            
//            supplierVC.supplier = self.supplier
//            
//        }
        
    }
    
    @IBAction func newButtonPressed(sender: AnyObject) {
        self.supplier = nil
        self.performSegueWithIdentifier("showSupplier", sender: nil)

    }

}
