//
//  NewOrder.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 15/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import UIKit

class NewOrder: UIViewController{

    override func viewDidLoad() {

        self.title = "New Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Product", style: .Plain, target: self, action: "addProduct:")
    }
    
    
    func addProduct(UIBarButtonItem!){
    
        self.performSegueWithIdentifier("presentModalNewProduct", sender: nil)
        
    }
    
}
