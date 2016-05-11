//
//  DictionaryMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 1/11/16.
//  Copyright © 2016 baydet. All rights reserved.
//

/**
*
*/
public protocol Mappable {
    init<T:Map>(_ map: T) throws
}

/**
 *
 */
public protocol DictionaryMapping: TransformType {
    associatedtype MappingFunction = (inout Object, Map) -> Void
    var mapFunction: MappingFunction { get }
    init(mapFunction:  MappingFunction)
}

public extension DictionaryMapping {
    
    func transformFromJSON(value: JSON?) -> Object? {
        return nil
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        return nil
    }
}