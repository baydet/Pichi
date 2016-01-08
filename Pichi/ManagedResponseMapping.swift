//
//  ManagedResponseMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import CoreData

public struct UniqueAttribute {
    public let modelKey: String
    public let jsonKey: String
    
    public init(modelKey: String, jsonKey: String) {
        self.modelKey = modelKey
        self.jsonKey = jsonKey
    }
}


public protocol CoreDataMappable: Mappable {
    static func identificationAttributes() -> [UniqueAttribute]
    static func predicate(attribute: UniqueAttribute, map: FromJSONMap) -> NSPredicate?
}

public extension CoreDataMappable where Self: NSManagedObject {
    static func identificationAttributes() -> [UniqueAttribute] {
        return []
    }
    
    init<T:Map>(_ map: T) throws {
        throw NSError(domain: "com.baydet.pichi", code: 0, userInfo: [NSLocalizedDescriptionKey : "unable to init NSManagedObject with init(_ map: T)"])
    }
}

//public func defaultPredicate(attribute: UniqueAttribute, map: ObjectMapper.Map) -> NSPredicate? {
//    let value: AnyObject? = map[attribute.jsonKey].value()
//    guard let str = value else {
//        return nil
//    }
//    return NSPredicate(format: "\(attribute.modelKey) == \(str)")
//}
//
//public extension CoreDataMappable {
//    static func predicate(attribute: UniqueAttribute, map: ObjectMapper.Map) -> NSPredicate? {
//        return defaultPredicate(attribute, map: map)
//    }
//}


public class ManagedObjectTransform<N where N: NSManagedObject, N:CoreDataMappable>: ResponseMapping<N> {
    private let context: NSManagedObjectContext?
    
    required public init(mapFunction: MappingFunction, context: NSManagedObjectContext?) {
        self.context = context
        super.init(mapFunction: mapFunction)
    }
    
    override func createObject(map: FromJSONMap) -> N? {
        guard let context = context else {
            return nil
        }
        if N.identificationAttributes().count > 0 {
            let identifiers = N.identificationAttributes()
            let predicates: [NSPredicate] = identifiers.flatMap{N.predicate($0, map: map)}
            let cachedObjects = context.find(entityType: N.self, predicate: NSCompoundPredicate(type: .AndPredicateType, subpredicates: predicates))
            if cachedObjects.count > 1 {
                print("Warning! More that one entity (\(cachedObjects.count)) of \(N.self) with identifiers \(identifiers) found")
            }
            
            guard let cachedObject = cachedObjects.first else {
                guard let newObject: N = context.insert() else {
                    return nil
                }
                return newObject
            }
            return cachedObject
        }
        guard let object: N = context.insert() else {
            return nil
        }
        return object
    }
    
}

