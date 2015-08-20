//
//  ChooseProduct.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 19/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Foundation
import Realm
import UIKit

//, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate
class ChooseProduct: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var Products : RLMResults!
    
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
        
        println("tus prods :: \(Products)")

        
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
        let productItem = self.Products.objectAtIndex(index) as! ProductsDao
        
        
        println("selecto \(productItem)")
        
        //            self.performSegueWithIdentifier("showSupplier", sender: nil)
    }
    
    
}