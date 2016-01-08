//
//  Model.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/21/15.
//  Copyright © 2015 baydet. All rights reserved.
//

import Pichi

let testJSON = ["string" : "test"]

struct Test: Mappable {
    var string: String = ""
    var optString: String? = ""
    var impString: String! = ""
    var null: String?
    var emptyKey: String?
    
    var array: [String] = []
    var optArray: [String]? = []
    var impArray: [String]! = []
    
    init<T:Map>(_ map: T) {
        
    }
    
    init(value: String) {
        string = value
        optString = value
        impString = value
        
        array = [value, value]
        optArray = array
        impArray = array
    }
}

struct SimpleTransform<T>: TransformType {
    typealias Object = T
    typealias JSON = T
    
    func transformFromJSON(value: JSON?) -> Object? {
        return value
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        return value
    }
}
