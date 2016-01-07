//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

infix operator <-> {}

public protocol TransformType {
    typealias Object
    typealias JSON
    
    func transformFromJSON(value: JSON?) -> Object?
    func transformToJSON(value: Object?) -> JSON?
}

/**
 *  This protocol defines high level abstraction for deserializing objects from JSON
 */
public protocol Map {
	subscript(key: String) -> Self { get }
    func value<T>() -> T?

    func <-> <T: JSONBasicConvertable>(inout left: T, right: Self)
    func <-> <T: JSONBasicConvertable>(inout left: T?, right: Self)
    func <-> <T: JSONBasicConvertable>(inout left: T!, right: Self)
    
    func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T, right: (Self, Transform))
    func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T?, right: (Self, Transform))
    func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T!, right: (Self, Transform))
}

/**
 *  Defines object that could be mapped to/from JSON
 */
public protocol Mappable {
	init<T:Map>(_ map: T) throws
}

/**
 *  Root class for mapping
 */
public protocol DictionaryMapping: TransformType {
    typealias MappingFunction = (inout Object, Map) -> Void
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