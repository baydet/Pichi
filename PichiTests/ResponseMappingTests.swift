//
//  ResponseMappingTests.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

class ResponseMappingTests: XCTestCase {
    
    func testBasicTypes() {
        
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
    
    func testRawRepresentable() {
        let value = EnumKey.Two
        let JSON : [String : AnyObject] = [
            "enum" : value.rawValue
        ]
        
        let map = FromJSONMap(JSON)
        var test = Test(map)
        rawRepresentableMapping(&test, map: map)
//        XCTAssertEqual(test.enumKey, value)
//        XCTAssertEqual(test.optEnumKey, value)
//        XCTAssertEqual(test.impEnumKey, value)
    }
    
    func testArrayMapping() {
        
        let value = "value"
        let arrValue = [value, value]
        let JSON : [String : AnyObject] = [
            "arr" : arrValue
        ]
        let map = FromJSONMap(JSON)
        var mapped: [String] = [""]
        mapped <-> map["arr"]
        XCTAssertEqual(mapped.count, arrValue.count)
        for i in 0..<mapped.count {
            XCTAssertEqual(mapped[i], arrValue[i])
        }
    }
    
    func testMappableArgument() {
        let value = "value"
        let JSON: [String : AnyObject] = [
            "subtest" : ["string" : value]
        ]
        
        let map = FromJSONMap(JSON)
        var test = Test(map)
        mappableOperatorMapping(&test, map: map)
        XCTAssertEqual(test.subTest.string, value)
    }
    
}
