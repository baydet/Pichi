//
//  RequestDictionaryMappingTests.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 1/7/16.
//  Copyright © 2016 baydet. All rights reserved.
//

import XCTest
import Pichi

func mapping<M: Map>(inout test: Test, map: M) {
    test.string <-> map["string"]
}

class RequestDictionaryMappingTests: XCTestCase {

    func testRequestDictionaryMapping() {
        let requestMapper = RequestDictionaryMapping<Test>(mapFunction: mapping)
        XCTAssertNil(requestMapper.transformToJSON(nil))
        
        let test = Test(value: "test")
        let json = requestMapper.transformToJSON(test) as? [String : String]
        XCTAssertEqual(json!, testJSON)
    }
    
    func testResponseMapper() {
        let responseMapper = ResponseDictionaryMapping<Test>(mapFunction: mapping)
        XCTAssertNil(responseMapper.transformFromJSON(nil))
        let test = responseMapper.transformFromJSON(testJSON)
        XCTAssertEqual(test?.string, "test")
    }

}
