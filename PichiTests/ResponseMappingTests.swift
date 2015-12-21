//
//  ResponseMappingTests.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

struct Test: Mappable {
    var string: String = ""
    var optString: String? = ""
    var impString: String! = ""
    var null: String?
    var emptyKey: String?
    var subTest: SubTest = SubTest()
    
    init?<T:Map>(_ map: T) {
        
    }
    
    init(value: String) {
        string = value
        optString = value
        impString = value
        subTest.string = value
    }
}

struct SubTest: Mappable {
    init?<T:Map>(_ map: T) {
        
    }

    var string: String = ""
    
    init() {
    }
}

func subtestMapping<T:Map>(inout test: SubTest, map: T) {
    test.string <-> map["string"]
}

func testMapping<T:Map>(inout test: Test, map: T) {
    test.string <-> map["string"]
    test.optString <-> map["optString"]
    test.impString <-> map["impString"]
    test.null <-> map["null"]
    test.emptyKey <-> map[""]
    test.subTest <-> (map["subtest"], subtestMapping)
}

class ResponseMappingTests: XCTestCase {
    
    func testBasicTypes() {
        
        let value = "value"
        let JSON : [String : AnyObject] = [
            "string" : value,
            "optString" : value,
            "impString" : value,
            "null" : NSNull(),
            "subtest" : ["string" : value]
        ]

        let map = FromJSONMap(JSON)
        var test = Test(map)!
        testMapping(&test, map: map)
        XCTAssertEqual(test.string, value)
        XCTAssertEqual(test.optString, value)
        XCTAssertEqual(test.impString, value)
        XCTAssertEqual(test.subTest.string, value)
        XCTAssertNil(test.null)
        XCTAssertNil(test.emptyKey)
        
    }
    
}
