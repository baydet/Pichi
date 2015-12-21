//
//  RequestMappingTests.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

class RequestMappingTests: XCTestCase {

    func testBasicTypes() {
        func testRequestMapping<T:Map>(inout test: Test, map: T) {
            test.string <-> map["string"]["nested"]
            test.optString <-> map["optString"]
            test.impString <-> map["impString"]
            test.null <-> map["null"]
            test.emptyKey <-> map[""]
        }
        
        let map = ToJSONMap()
        let value = "test"
        var test = Test(value: "test")
        testRequestMapping(&test, map: map)
        let dictionary: [String : AnyObject]! = map.value()
        let fromJSON = FromJSONMap(dictionary)

        var mappedTest = Test(value: "")
        testRequestMapping(&mappedTest, map: fromJSON)
        XCTAssertEqual(mappedTest.string, value)
        XCTAssertEqual(mappedTest.optString, value)
        XCTAssertEqual(mappedTest.impString, value)
        XCTAssertNil(mappedTest.null)
        XCTAssertNil(mappedTest.emptyKey)
        print(value)
    }
    
    func testMappableArgument() {
        let map = ToJSONMap()
        let value = "test"
        var test = Test(value: "test")
        mappableOperatorMapping(&test, map: map)
        let dictionary: [String : AnyObject]! = map.value()
        let fromJSON = FromJSONMap(dictionary)
        
        var mappedTest = Test(value: "")
        mappableOperatorMapping(&mappedTest, map: fromJSON)
        XCTAssertEqual(mappedTest.subTest.string, value)
    }
}
