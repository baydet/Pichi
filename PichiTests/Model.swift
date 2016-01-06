//
//  Model.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/21/15.
//  Copyright © 2015 baydet. All rights reserved.
//

import Pichi

enum EnumKey: String {
    case One = "one"
    case Two = "two"
}

struct Test: Mappable {
    var string: String = ""
    var optString: String? = ""
    var impString: String! = ""
    var null: String?
    var emptyKey: String?
    
    var array: [String] = []
    var optArray: [String]? = []
    var impArray: [String]! = []
    
    var enumKey: EnumKey = .One
    var optEnumKey: EnumKey? = nil
    var impEnumKey: EnumKey! = nil
    
    var subTest: SubTest = SubTest()
    
    init<T:Map>(_ map: T) {
        
    }
    
    init(value: String) {
        string = value
        optString = value
        impString = value
        subTest.string = value
        
        array = [value, value]
        optArray = array
        impArray = array
    }
}

struct SubTest: Mappable {
    init<T:Map>(_ map: T) {
        
    }
    
    var string: String = ""
    
    init() {
    }
}

func subtestMapping<T:Map>(inout test: SubTest, map: T) {
    test.string <-> map["string"]
}

//func mappableOperatorMapping<T:Map>(inout test: Test, map: T) {
//    test.subTest <-> (map["subtest"], subtestMapping)
//}

func rawRepresentableMapping<T:Map>(inout test: Test, map: T) {
//    test.enumKey <-> map["enum"]
//    test.optEnumKey <-> map["enum"]
//    test.impEnumKey <-> map["enum"]
}
