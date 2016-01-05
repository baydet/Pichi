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
    
//    func testCollectionMapping() {
//        var test = Test(value: "test")
//        func testArrayMapping(inout test: Test, map: ToJSONMap) {
//            test.array <-> map["array"]
//            test.optArray <-> map["optArray"]
//            test.impArray <-> map["impArray"]
//        }
//        
//        func fromJSONArrayMapping(inout test: Test, map: FromJSONMap) {
//            test.array <-> map["array"]
//            test.optArray <-> map["optArray"]
//            test.impArray <-> map["impArray"]
//        }
//        
//        let map = ToJSONMap()
//        
//        testArrayMapping(&test, map: map)
//        
//        let fromJSONMap = FromJSONMap(map.value())
//        var mappedTest = Test(fromJSONMap)
//        fromJSONArrayMapping(&mappedTest, map: fromJSONMap)
//
//        XCTAssertEqual(test.array.count, mappedTest.array.count)
//        XCTAssertEqual(test.optArray?.count, mappedTest.optArray?.count)
//        XCTAssertEqual(test.impArray.count, mappedTest.impArray.count)
//    }
//
    
//    func testMappable() {
//        let map = ToJSONMap()
//        let value = "test"
//        var test = Test(value: "test")
//        mappableOperatorMapping(&test, map: map)
//        let dictionary: [String : AnyObject]! = map.value()
//        let fromJSON = FromJSONMap(dictionary)
//        
//        var mappedTest = Test(value: "")
//        mappableOperatorMapping(&mappedTest, map: fromJSON)
//        XCTAssertEqual(mappedTest.subTest.string, value)
//    }
}
