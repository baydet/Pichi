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
        print(value)
    }
    
    func testNestedMapping() {
        
    }
    
    func testCollectionMapping() {
        
        var test = Test(value: "test")
        func testArrayMapping(inout test: Test, map: ToJSONMap) {
            test.array <-> map["array"]
            test.optArray <-> map["optArray"]
            test.impArray <-> map["impArray"]
        }
        
        let map = ToJSONMap()
        
//        arrValue <-> map
        
//        let fromJSONMap = FromJSONMap(map.value())
//        print(fromJSONMap.value()!)
//        var mapped: [String] = []
//        mapped <-> fromJSONMap
//        
//        XCTAssertEqual(mapped.count, arrValue.count)
//        for i in 0..<mapped.count {
//            XCTAssertEqual(mapped[i], arrValue[i])
//        }
    }

    
    func testMappable() {
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
