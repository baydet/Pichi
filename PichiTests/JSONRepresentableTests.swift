//
//  JSONRepresentableTests.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 1/4/16.
//  Copyright © 2016 baydet. All rights reserved.
//

import XCTest

class JSONRepresentableTests: XCTestCase {
    
    func testString() {
        let value = "test"
        let string = value
        let fromJSON = String(jsonObject: value)
        let fromJSONNil = String(jsonObject: 2)
        XCTAssertEqual(string.jsonValue, value)
        XCTAssertEqual(fromJSON, value)
        XCTAssertNil(fromJSONNil)
    }
    
    func testDouble() {
        let double: Double = 1.1
        XCTAssertEqual(double.jsonValue, Float(double))
    }

    func testInt64() {
        let int: Int64 = 1
        XCTAssertEqual(int.jsonValue, Int(int))
    }

    func testInt32() {
        let value = 1
        let int = Int32(value)
        let fromJSON = Int32(jsonObject: value)
        XCTAssertEqual(int.jsonValue, value)
        XCTAssertEqual(fromJSON, Int32(value))
    }

    func testInt16() {
        let int: Int16 = 1
        XCTAssertEqual(int.jsonValue, Int(int))
    }

    func testInt8() {
        let int: Int8 = 1
        XCTAssertEqual(int.jsonValue, Int(int))
    }

    func testBool() {
        let bool: Bool = true
        XCTAssertEqual(bool.jsonValue, bool)
    }


}
