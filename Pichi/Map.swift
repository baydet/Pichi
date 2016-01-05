//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

import CoreData

infix operator <-> {}

public protocol TransformType {
    typealias Object
    typealias JSON
    
    func transformFromJSON(value: AnyObject?) -> Object?
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
    
//    func <-> <T: Mappable>(inout left: T, right: (Self, Mapping<T, Self>))
//    func <-> <T: Mappable>(inout left: T!, right: (Self, Mapping<T, Self>))
//    func <-> <T: Mappable>(inout left: T?, right: (Self, Mapping<T, Self>))
//
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
public class Mapping<N: Mappable, T: Map>/*: TransformType*/ {
	public typealias MappingFunction = (inout N, T) -> Void
    public typealias Object = N
    public typealias JSON = [String : AnyObject]
    
	let mapFunction: MappingFunction

    required public init(mapFunction:  MappingFunction) {
		self.mapFunction = mapFunction
	}
    
//    public func transformFromJSON(value: AnyObject?) -> Object? {
//        let map = FromJSONMap(value)
//        guard var object = try? N(map) else {
//            return nil
//        }
//        mapFunction(&object, map)
//        return object
//    }
//    
//    public func transformToJSON(value: Object?) -> JSON? {
//        let map = ToJSONMap()
//        guard var object = value else {
//            return nil
//        }
//        self.mapFunction(&object, map)
//        return map.value()
//    }
}