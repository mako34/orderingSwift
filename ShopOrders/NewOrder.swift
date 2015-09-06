//
//  NewOrder.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 15/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Alamofire
import Realm
import UIKit
import MBProgressHUD
import SwiftyJSON

class NewOrder: BaseViewController{

    var order : OrderDao?
    var hud: MBProgressHUD = MBProgressHUD()
    var productNames = [String]()
    var productsSeparated = [Dictionary<String, Any>?]()
    var indexPost : Int?
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderName: UITextField!
    @IBOutlet weak var itemsOrdered: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexPost = 0
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        println("entro : \(order)")
   
    }
    
    override func viewDidAppear(animated: Bool) {
        initWidgets()

    } 
    
    override func viewDidLayoutSubviews() {
        initWidgets()

    }
    
    func back(sender: UIBarButtonItem) {
        
        println("backeado")
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
            
            if(order!.productsOrdered.count > 0){
                submitButton.alpha = 1
            }
            
            tableView .reloadData()
            
            
            if(order?.submitted == true){
                disableSubmitButton()
            }
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
    

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //alert n delete!
            let realm = RLMRealm.defaultRealm() //1
            
            let prodItem = order?.productsOrdered.objectAtIndex(UInt(indexPath.row)) as! ProductOrderedDao

//            let objectToDelete = self.suppliers[UInt(indexPath.row)] as! Supplier //2
            realm.beginWriteTransaction() //3
            realm.deleteObject(prodItem) //4
            realm.commitWriteTransaction() //5
            
//            self.suppliers = Supplier.allObjects()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //7
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    

    @IBAction func submitButtonPressed(sender: AnyObject) {
        
       separateOrderProductsBySupplier()


    }
    
    func separateOrderProductsBySupplier(){
        
        //brute force algol!
        if(order?.productsOrdered.count > 0){
            //            println("array :: \(order?.productsOrdered)")
            
            productNames.removeAll(keepCapacity: false)
            
            for product in order!.productsOrdered as RLMArray  {
                
                var prod :(ProductOrderedDao) = product as! ProductOrderedDao
                //dime el producto ,
                let predicate = NSPredicate(format: "name BEGINSWITH [c] %@", prod.name)
                let productOriginalArraya = ProductsDao.objectsWithPredicate(predicate)
                let prodOriginal = productOriginalArraya.firstObject() as! ProductsDao
                
                productNames.append(prodOriginal.supplier.name)
                
                
            }
            
            let unique = Array(Set(productNames))
            var productArraya = [NSDictionary]()
            
            for supplierName in unique {
                var prodDicto = Dictionary<String, Any>()
                var orderConstructedArraya = [Any]()
                
                prodDicto["supplier"] = supplierName
                
                //find supplier! horrible but fix soon
                let predicate = NSPredicate(format: "name BEGINSWITH [c] %@", supplierName)
                let supplierArraya = Supplier.objectsWithPredicate(predicate)
                let sup = supplierArraya.firstObject() as! Supplier
                prodDicto["supplierEmail"] = sup.email

                
                for product in order!.productsOrdered as RLMArray  {
                    
                    var prod :(ProductOrderedDao) = product as! ProductOrderedDao
                    let predicate = NSPredicate(format: "name BEGINSWITH [c] %@", prod.name)
                    let productOriginalArraya = ProductsDao.objectsWithPredicate(predicate)
                    let prodOriginal = productOriginalArraya.firstObject() as! ProductsDao
                    

                    if (supplierName == prodOriginal.supplier.name){
                        var prodItemDicto = [String : String]()
                        prodItemDicto["productName"] = prod.name
                        prodItemDicto["productQuantity"] = prod.quantity
                        orderConstructedArraya.append(prodItemDicto)
                    }
                    
                }
                prodDicto["products"] = orderConstructedArraya
                productsSeparated .append(prodDicto)
                
            }
            
            
            println("t; \(productsSeparated)")
            
            
            postOrder()
        }
    }
    
    func postOrder(){

        //separate by suppliers! donsky
        //send one by one,
        
        
        
        let indexPlus:Int = indexPost! + 1
        
        if (indexPlus <= productsSeparated.count){
            
            if let dictin = productsSeparated[indexPost!] {
                
                println("va el index \(indexPost)")
                postOrderService(dictin)
                
            }
            
        }
        

        
  
    }
    
    
    func postOrderService(dictin : Dictionary<String, Any>){
        
        println("tdictin; \(dictin)")

        
        let header_distributor = dictin["supplier"] as! String
        let supplier_email = dictin["supplierEmail"] as! String
        
        //format date
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY hh:mm" //format style. Browse online to get a format that fits your needs.
        var dateString = dateFormatter.stringFromDate(order!.date)
        
        let shop_name = "my supa shopa"
        
        //arma productos arraya
        let productsArray = dictin["products"]
        
        var productsString:String = " \(productsArray!)"
        
//        for prodDicto in productsArray{
//            let productName = prodDicto["productName"]
//            let productQuantity = prodDicto["productQuantity"]
//        }
        
        let parameters = [
            "key": "S0ksg6WvhNXZbLKw8_ueGw",
            "template_name": "orderingtemplate",
            "template_content": [
                [
                    "name": "header_distributor",
                    "content": header_distributor
                    ] as [String : String]!,
                [
                    "name": "date",
                    "content": dateString
                    ] as [String : String]!,
                [
                    "name": "shop_name",
                    "content": shop_name
                    ] as [String : String]!,
                [
                    "name": "products",
                    "content": productsString
                    ] as [String : String]!
            ],
            "message": [
                "text": "Example text 222content",
                "subject": "You have an order",
                "from_email": "manuel.betancurt@codesource.com.au",
                "from_name": "Example Name",
                "to": [
                    [
                        "email": supplier_email,
                        "name": header_distributor,
                        "type": "to"
                    ]
                ],
                "headers": [
                    "Reply-To": "troppo@gizmomen.com"
                ],
                "important": false,
                "bcc_address": "message.bcc_address@example.com",
                "merge": true,
                "merge_language": "mailchimp",
                "global_merge_vars": [
                    [
                        "name": "merge1",
                        "content": "merge1 content"
                    ]
                ],
                "merge_vars": [
                    [
                        "rcpt": "recipient.email@example.com",
                        "vars": [
                            [
                                "name": "merge2",
                                "content": "merge2 content"
                            ]
                        ]
                    ]
                ],
                "tags": [
                    "password-resets"
                ],
                "recipient_metadata": [
                    [
                        "rcpt": "recipient.email@example.com",
                        "values": [
                            "user_id": 123456
                        ]
                    ]
                ]
            ],
            "async": false,
            "ip_pool": "Main Pool"
            
        ]

        hud .show(true)

        
        Alamofire.request(.POST, "https://mandrillapp.com/api/1.0/messages/send-template.json", parameters: parameters as? [String : AnyObject], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                
                println("response :: \(response)")
                
                if let anError = error
                {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                    
                    self.hud .hide(true)
                }
                else if let data: AnyObject = data
                {
                    self.hud .hide(true)

                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(data)
                    // to make sure it posted, print the results
                    //                    println("The post is: " + post.description)
                    println("post :: \(post)")
                    
                    let realm = RLMRealm.defaultRealm()
                    realm.beginWriteTransaction() //begin

                    self.order?.submitted = true
                    
                    realm.commitWriteTransaction() //save

                    
                    self.disableSubmitButton()
                    
                    self.indexPost!+=1
                    self.postOrder()
                }
        }
    }
    
    
    func disableSubmitButton(){
        self.submitButton.titleLabel?.text = "Submitted"
        self.submitButton.backgroundColor = UIColor.blueColor()
        self.submitButton.enabled = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let productsVC = segue.destinationViewController as? ChooseProduct {
            productsVC.order = order
        }
        
    }
    
    
    
}
