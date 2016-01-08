//
//  ResponseDictionaryMappingTests.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

class FromJSONMapTests: XCTestCase {
    
    func testBasicTypes() {
        
        func testMapping<T:Map>(inout test: Test, map: T) {
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
            "null" : NSNull(),
        ]

        let map = FromJSONMap(JSON)
        var test = Test(map)
        testMapping(&test, map: map)
        XCTAssertEqual(test.string, value)
        XCTAssertEqual(test.optString, value)
        XCTAssertEqual(test.impString, value)
        XCTAssertNil(test.null)
        XCTAssertNil(test.emptyKey)
    }
    
    func testTransformTypes() {
        let value = "value"
        let JSON : [String : AnyObject] = [
            "string" : value,
            "optString" : value,
            "impString" : value,
        ]
        
        func testMapping<T:Map>(inout test: Test, map: T) {
            test.string <-> (map["string"], SimpleTransform<String>())
            test.optString <-> (map["optString"], SimpleTransform<String>())
            test.impString <-> (map["impString"], SimpleTransform<String>())
        }
        
        let map = FromJSONMap(JSON)
        var test = Test(map)
        testMapping(&test, map: map)
        XCTAssertEqual(test.string, value)
        XCTAssertEqual(test.optString, value)
        XCTAssertEqual(test.impString, value)
        XCTAssertNil(test.null)
        XCTAssertNil(test.emptyKey)
    }
    
}
