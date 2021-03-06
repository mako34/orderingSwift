//
//  MyOrdersTableViewController.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 20/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Realm
import UIKit

class MyOrdersTableViewController: UITableViewController {

    var myOrders : RLMResults!
    var order : OrderDao?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
//        initWidgets()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        initWidgets()

    }
 
    func initWidgets(){
        //give me the orders son
        var orders : RLMResults{
            get {
                return OrderDao.allObjects().sortedResultsUsingProperty("date", ascending: false)
            }
        }
        
        myOrders =  orders
        println("me entro \(orders)")
        
        self.tableView .reloadData()
        
        let accounts = AccountDAO.allObjects()
        if let account:AccountDAO = accounts.firstObject() as? AccountDAO{
            println("saba")
            
        }else{
//            self.performSegueWithIdentifier("showAccountModal", sender: nil)
            
        }
        
        
        

 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func newOrderButtonPressed(sender: AnyObject) {
        order = nil
        self.performSegueWithIdentifier("showOrder", sender: nil)

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
        if(myOrders == nil){
            return 0
        }
        return Int(myOrders.count)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        
        let index = UInt(indexPath.row)
        let orderItem = myOrders.objectAtIndex(index) as! OrderDao
        
        cell.textLabel?.text = orderItem.name

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        let index = UInt(indexPath.row)
        let orderItem = myOrders.objectAtIndex(index) as! OrderDao
        order = orderItem
        
        self.performSegueWithIdentifier("showOrder", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        if(segue.identifier == "showOrder"){
            let orderVC = segue.destinationViewController as? NewOrder
            orderVC?.order = order
        }else if(segue.identifier == "showAccountModal"){
            
        }
        

//        supplierVC!.supplier = self.supplier
    }
    
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
     
        self.performSegueWithIdentifier("showAccountModal", sender: nil)

    }


}
