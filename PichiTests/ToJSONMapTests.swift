//
//  RequestMappingTests.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import XCTest
import Pichi

class ToJSONMapTests: XCTestCase {

    func testJSONBasicConvertable() {
        func testRequestMapping<T:Map>(inout test: Test, map: T) {
            test.string <-> map["string"]
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
    }
    
    func testNestedMapping() {
        func testNestedMapping<T:Map>(inout test: Test, map: T) {
            test.string <-> map["nested"]["string"]
        }
        
        let map = ToJSONMap()
        
        var test = Test(value: "test")
        testNestedMapping(&test, map: map)
        let dictionary: [String : AnyObject]! = map.value()
        let fromJSON = FromJSONMap(dictionary)
        
        var mappedTest = Test(value: "")
        testNestedMapping(&mappedTest, map: fromJSON)
        XCTAssertEqual(mappedTest.string, test.string)
    }
    
    func testRootArrayMapping() {
        func testArrayMapping<T:Map>(inout test: Test, map: T) {
            test.array <-> (map, SimpleTransform<[String]>())
        }
        
        let map = ToJSONMap()
        
        var test = Test(value: "test")
        testArrayMapping(&test, map: map)
        let array: [String]! = map.value()
        let fromJSON = FromJSONMap(array)
        
        var mappedTest = Test(value: "")
        testArrayMapping(&mappedTest, map: fromJSON)
        XCTAssertEqual(mappedTest.array, test.array)
    }
    
    func testTransformTypes() {
        func testMapping<T:Map>(inout test: Test, map: T) {
            test.string <-> (map["string"], SimpleTransform<String>())
            test.optString <-> (map["optString"], SimpleTransform<String>())
            test.impString <-> (map["impString"], SimpleTransform<String>())
        }
        
        let map = ToJSONMap()
        let value = "test"
        var test = Test(value: "test")
        testMapping(&test, map: map)
        let dictionary: [String : AnyObject]! = map.value()
        let fromJSON = FromJSONMap(dictionary)
        
        var mappedTest = Test(value: "")
        testMapping(&mappedTest, map: fromJSON)
        XCTAssertEqual(mappedTest.string, value)
        XCTAssertEqual(mappedTest.optString, value)
        XCTAssertEqual(mappedTest.impString, value)
    }

}
