//
//  CoreDataMapperTests.swift
//  Cingulata
//
//  Created by Alexandr Evsyuchenya on 10/25/15.
//  Copyright © 2015 baydet. All rights reserved.
//

import XCTest
import CoreData
@testable import Pichi

func managedMapping<M: Map>(inout test: ManagedData, map: M) {
    test.text <-> map["string"]
}

func managedUniqueMapping<M: Map>(inout test: UniqueData, map: M) {
    test.identifier <-> map["identifier"]
}


class CoreDataMapperTests: XCTestCase {
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        let bundle = NSBundle(forClass: self.classForCoder)
        
        let model = NSManagedObjectModel(contentsOfURL: bundle.URLForResource("Model", withExtension: "momd")!)!
        let storeCoordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! storeCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = storeCoordinator
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCoreDataMapping() {
        let mapping = ManagedObjectTransform<ManagedData>(mapFunction: managedMapping, context: context)
        XCTAssertNil(mapping.transformFromJSON(nil))
        let test = mapping.transformFromJSON(testJSON)
        XCTAssertEqual(test?.text, "test")
        
        let nilMapping = ManagedObjectTransform<ManagedData>(mapFunction:
            managedMapping, context: nil)
        XCTAssertNil(nilMapping.transformFromJSON(testJSON))
    }
    
    func testUniqueCoreDataMapping() {
        let mapping = ManagedObjectTransform<UniqueData>(mapFunction:
            managedUniqueMapping, context: context)
        let json = ["identifier" : 13]

        let _ = mapping.transformFromJSON(json)
        XCTAssertEqual(context.find(entityType: UniqueData.self).count, 1)

        let _ = mapping.transformFromJSON(json)
        XCTAssertEqual(context.find(entityType: UniqueData.self).count, 1)
    }
    
    func testDeleteOrphanedObjects() {
        
    }

}
