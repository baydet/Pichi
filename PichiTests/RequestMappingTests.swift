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
    
    func testRawRepresentable() {
        
        func rawRepresentableRequestMapping<T:Map>(inout test: Test, map: T) {
//            test.enumKey <-> map["enum"]
//            test.optEnumKey <-> map["opt"]
//            test.impEnumKey <-> map["imp"]
        }

        let map = ToJSONMap()
        let value = EnumKey.Two
        var test = Test(value: "")
        test.enumKey = EnumKey.Two
        test.impEnumKey = EnumKey.Two
        test.optEnumKey = EnumKey.Two
        rawRepresentableRequestMapping(&test, map: map)
        let dictionary: [String : AnyObject]! = map.value()
        let fromJSON = FromJSONMap(dictionary)
        
        var mappedTest = Test(value: "")
        rawRepresentableRequestMapping(&mappedTest, map: fromJSON)
//        XCTAssertEqual(mappedTest.enumKey, value)
//        XCTAssertEqual(mappedTest.optEnumKey, value)
//        XCTAssertEqual(mappedTest.impEnumKey, value)
    }
    
    func testArrayMapping() {
        
        let value = "value"
        var arrValue = [value, value]
        let map = ToJSONMap()
        arrValue <-> map
        
        print(map.value()!)
        let fromJSONMap = FromJSONMap(map.value())
        print(fromJSONMap.value()!)
        var mapped: [String] = []
        mapped <-> fromJSONMap
        
        XCTAssertEqual(mapped.count, arrValue.count)
        for i in 0..<mapped.count {
            XCTAssertEqual(mapped[i], arrValue[i])
        }
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
