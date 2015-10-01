//
//  Supplier.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//


import Realm


class Supplier: RLMObject {
    dynamic var name = ""
    dynamic var email = ""
    dynamic var phone = ""
    dynamic var cutOffDay = ""

    dynamic var products = RLMArray(objectClassName: ProductsDao.className())
    
} 