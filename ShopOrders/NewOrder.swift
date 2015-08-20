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
    
    @IBOutlet weak var orderName: UITextField!
    override func viewDidLoad() {

        self.title = "New Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Product", style: .Plain, target: self, action: "addProduct:")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let productsVC = segue.destinationViewController as? ChooseProduct {
            productsVC.order = order
        }
        
    }
    
}
