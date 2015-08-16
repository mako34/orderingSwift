//
//  Supplier.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 16/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Foundation
import CoreData

@objc(Supplier)

class Supplier: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var phone: String

}
