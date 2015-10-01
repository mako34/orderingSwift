//
//  AccountDAO.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 3/09/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Realm

class AccountDAO: RLMObject {

    dynamic var shopName = ""
    dynamic var address = ""
    dynamic var phone = ""
    dynamic var email = ""
    dynamic var contactName = ""
    dynamic var abn = ""
    dynamic var url = ""
    dynamic var openingTime = ""
    dynamic var closingTime = ""
    dynamic var instructions = ""

    
}
