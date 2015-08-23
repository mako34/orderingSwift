//
//  NewOrder.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 15/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Realm
import UIKit

class NewOrder: BaseViewController{

    var order : OrderDao?
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderName: UITextField!
    @IBOutlet weak var itemsOrdered: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        println("entro : \(order)")
        
         
        
    }
    
    override func viewDidAppear(animated: Bool) {
        initWidgets()

    }
    
    func back(sender: UIBarButtonItem) {
        
        println("backeado")
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewControllerAnimated(true)
    }
 
    
    func initWidgets(){
        self.title = "New Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Product", style: .Plain, target: self, action: "addProduct:")
        
        if(order == nil){
            orderDate.text = shortDate(NSDate())
            orderName.placeholder = "Enter name"
            itemsOrdered.text = "Enter products"
            
        }else{
            orderDate.text = shortDate(order!.date)
            orderName.text = order?.name
            itemsOrdered.text = String(stringInterpolationSegment: order!.productsOrdered.count)
            
            tableView .reloadData()
        }
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
            
            //check if exist if not create new,
            let predicate = NSPredicate(format: "name BEGINSWITH [c] %@", orderName.text)
            let orderResults = OrderDao.objectsWithPredicate(predicate)
            let realm = RLMRealm.defaultRealm()
            
            if(orderResults.count == 0){
                
                let orderInserto = OrderDao()
                orderInserto.name = orderName.text
                order = orderInserto
                realm.transactionWithBlock(){
                    realm.addObject(orderInserto)
                }
            }else{
                let orderObj : OrderDao = orderResults.firstObject() as! OrderDao
                realm.beginWriteTransaction() //begin
                orderObj.name = orderName.text //set
                order = orderObj
                realm.commitWriteTransaction() //save

            }
 
            self.performSegueWithIdentifier("presentModalNewProduct", sender: nil)

        }

        
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
        if(order != nil)
        {
            return Int(order!.productsOrdered.count)
        }
        return 0
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        footerView.backgroundColor = UIColor.lightGrayColor()
        
        let lava = UILabel(frame: CGRectMake(10, 2, 200, 15))
        lava.text = "Products"
        
        
        lava.font = UIFont(name: lava.font.fontName, size: 11)

        
        footerView .addSubview(lava)
        
        return footerView
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellProducts")
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CellProducts")
        
        let index = UInt(indexPath.row)
        let prodItem = order?.productsOrdered.objectAtIndex(index) as! ProductOrderedDao
        
        cell.textLabel?.text = prodItem.name
        cell.detailTextLabel?.text = prodItem.quantity
        
        return cell
 
        
     }
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)

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
