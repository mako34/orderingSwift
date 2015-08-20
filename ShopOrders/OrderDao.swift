//
//  OrderDao.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 19/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Foundation
import Realm


class OrderDao: RLMObject {
    dynamic var date = NSDate() 
    dynamic var name = ""
    dynamic var repeat = ""
    
    dynamic var productsOrdered = RLMArray(objectClassName: ProductOrderedDao.className())
    
}