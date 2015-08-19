//
//  RLMSupport.swift
//  ShopOrders
//
//  Created by TKT_SS9_43 on 18/08/2015.
//  Copyright (c) 2015 Hyper. All rights reserved.
//

import Foundation
import Realm

extension RLMObject {
    // Swift query convenience functions
    public class func objectsWhere(predicateFormat: String, _ args: CVarArgType...) -> RLMResults {
        return objectsWithPredicate(NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
    
    public class func objectsInRealm(realm: RLMRealm, _ predicateFormat: String, _ args: CVarArgType...) -> RLMResults {
        return objectsInRealm(realm, withPredicate:NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
}

public class RLMGenerator: GeneratorType {
    private var i: UInt = 0
    private let collection: RLMCollection
    
    init(collection: RLMCollection) {
        self.collection = collection
    }
    
    public func next() -> RLMObject? {
        if i >= collection.count {
            return .None
        } else {
            return collection[i++] as? RLMObject
        }
    }
}

extension RLMArray: SequenceType {
    // Support Sequence-style enumeration
    public func generate() -> RLMGenerator {
        return RLMGenerator(collection: self)
    }
    
    // Swift query convenience functions
    public func indexOfObjectWhere(predicateFormat: String, _ args: CVarArgType...) -> UInt {
        return indexOfObjectWithPredicate(NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
    
    public func objectsWhere(predicateFormat: String, _ args: CVarArgType...) -> RLMResults {
        return objectsWithPredicate(NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
}

extension RLMResults: SequenceType {
    // Support Sequence-style enumeration
    public func generate() -> RLMGenerator {
        return RLMGenerator(collection: self)
    }
    
    // Swift query convenience functions
    public func indexOfObjectWhere(predicateFormat: String, _ args: CVarArgType...) -> UInt {
        return indexOfObjectWithPredicate(NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
    
    public func objectsWhere(predicateFormat: String, _ args: CVarArgType...) -> RLMResults {
        return objectsWithPredicate(NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }
}