//
//  ManagedResponseDictionaryMapping.swift
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
    
    public init(key: String) {
        self.modelKey = key
        self.jsonKey = key
    }
}

public protocol CoreDataMappable: class, Mappable {
    static func identificationAttributes() -> [UniqueAttribute]
    static func predicate(attribute: UniqueAttribute, map: FromJSONMap) -> NSPredicate?
}

public extension CoreDataMappable where Self: NSManagedObject {
    static func identificationAttributes() -> [UniqueAttribute] {
        return []
    }
    
    static func predicate(attribute: UniqueAttribute, map: FromJSONMap) -> NSPredicate? {
        return defaultPredicate(attribute, map: map)
    }

}

public func defaultPredicate(attribute: UniqueAttribute, map: FromJSONMap) -> NSPredicate? {
    let value: AnyObject? = map[attribute.jsonKey].value()
    guard let str = value else {
        return nil
    }
    return NSPredicate(format: "\(attribute.modelKey) == \(str)")
}


public class ManagedObjectTransform<N where N: NSManagedObject, N:CoreDataMappable>: ResponseDictionaryMapping<N> {
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
    
    override public func transformFromJSON(value: JSON?) -> N? {
        defer {
            saveContext()
        }
        return super.transformFromJSON(value)
    }
    
    private func saveContext() -> Bool {
        guard let context = context else {
            return false
        }
        var localError: NSError? = nil
        if context.insertedObjects.count > 0 {
            context.performBlockAndWait() {
                do {
                    try context.obtainPermanentIDsForObjects(Array(context.insertedObjects))
                } catch let err as NSError {
                    localError = err
                }
            }
        }
        
        if localError != nil {
            return false
        }
        
        context.performBlockAndWait() {
            do {
                try context.save()
            } catch let err as NSError {
                localError = err
            }
        }
        
        if localError != nil {
            print("Error during mapping \(localError)")
            return false
        }
        
        
        return true
    }
}

