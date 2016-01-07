//
//  CollectionTransformsTests.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 1/7/16.
//  Copyright © 2016 baydet. All rights reserved.
//

import XCTest
import Pichi

class CollectionTransformsTests: XCTestCase {

    let testArray: [String] = ["test"]
    
    func testBasicCollectionToJSON() {
        let basicArrTransform = BasicArrayTransform<String>()
        XCTAssertEqual(basicArrTransform.transformFromJSON(testArray)!, testArray)
        XCTAssertEqual(basicArrTransform.transformToJSON(testArray)!, testArray)
        XCTAssertNil(basicArrTransform.transformFromJSON(nil))
        
        let basicSetTransform = BasicSetTransform<String>()
        XCTAssertEqual(basicSetTransform.transformFromJSON(testArray)!, Set<String>(testArray))
        XCTAssertNil(basicSetTransform.transformFromJSON(nil))
    }
    
    func testTransformTypeArrayTransformTest() {
        let arrTransform = TransformTypeArrayTransform<SimpleTransform<String>>(SimpleTransform())
        XCTAssertEqual(arrTransform.transformFromJSON(testArray)!, testArray)
        XCTAssertEqual(arrTransform.transformToJSON(testArray)!, testArray)
        XCTAssertNil(arrTransform.transformFromJSON(nil))
    }

}
