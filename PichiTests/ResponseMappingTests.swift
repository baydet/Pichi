//
//  ResponseMappingTests.swift
//  Cingulata
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

struct Test: nMappable {
    var string: String = ""
    var optString: String? = ""
    var impString: String! = ""
    var null: String?
    var emptyKey: String?
    
    init?<T: nMap>(_ map: T) {
        
    }
    
    init(value: String) {
        string = value
        optString = value
        impString = value
    }
}

class ResponseMappingTests: XCTestCase {
    
    func testBasicTypes() {
        func testMapping<T: nMap>(inout test: Test, map: T) {
            test.string <-> map["string"]
            test.optString <-> map["optString"]
            test.impString <-> map["impString"]
            test.null <-> map["null"]
            test.emptyKey <-> map[""]
        }
    
        let value = "value"
        let JSON : [String : AnyObject] = [
            "string" : value,
            "optString" : value,
            "impString" : value,
            "null" : NSNull()
        ]

        let map = FromJSONMap(JSON)
        var test = Test(map)!
        testMapping(&test, map: map)
        XCTAssertEqual(test.string, value)
        XCTAssertEqual(test.optString, value)
        XCTAssertEqual(test.impString, value)
        XCTAssertNil(test.null)
        XCTAssertNil(test.emptyKey)
        
    }
    
}