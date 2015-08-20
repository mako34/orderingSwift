//
//  ChooseProduct.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 19/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import ActionSheetPicker_3_0
import Foundation
import Realm
import UIKit

//, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate
class ChooseProduct: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var Products : RLMResults!
    var order : OrderDao?
    var productItem : ProductsDao?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        //get all prods!
     
        var products : RLMResults {
            get { //q es el get?
                return ProductsDao.allObjects().sortedResultsUsingProperty("name", ascending: true)
            }
        }
        
        Products = products
        
        println("me entro \(order)")
        
    }
 
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Int(self.Products.count)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        
        let index = UInt(indexPath.row)
        let productItem = self.Products.objectAtIndex(index) as! ProductsDao
        
        cell.textLabel?.text = productItem.name
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        let index = UInt(indexPath.row)
        productItem = self.Products.objectAtIndex(index) as? ProductsDao
        
        
        println("selecto \(productItem)")
        
        //            self.performSegueWithIdentifier("showSupplier", sender: nil)
        
        
        var numberOfProducts : [Int] = []
        var i = 0
        var count : Int = 0
        for i in 1...50 {
//            numberOfProducts += count
            
            count += 1
            numberOfProducts.append(count)
            
        }
                
        ActionSheetStringPicker.showPickerWithTitle("How many \(productItem!.name)", rows: numberOfProducts, initialSelection: 0, doneBlock: {
            picker, value, index in
            
            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
            
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            
            let productOrderInserto = ProductOrderedDao()
            productOrderInserto.name = self.productItem!.name
            productOrderInserto.quantity = String(value)
            self.order?.productsOrdered.addObject(productOrderInserto)
            
            realm.addObject(productOrderInserto)
            realm.commitWriteTransaction()
            
            //nota, necesito estas 4 lineas de arriba? magical era mas magico!
            
            self .dismissViewControllerAnimated(true, completion: nil)
            
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.tableView)

    }
    
    
}