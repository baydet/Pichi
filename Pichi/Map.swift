//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

infix operator <-> {}

enum MapError: ErrorType {
    case UnexpectedValueType
}

//public enum JSONValue {
//    case string
//    case Bool
//    case Number
//    case Null
//}

public protocol JSONConvertable {
    typealias JSON
    var jsonValue: JSON { get }
}

extension String: JSONConvertable {
    public typealias JSON = String
    
    public var jsonValue: JSON {
        return self
    }
}

public protocol JSONRawRepresentable: RawRepresentable, JSONConvertable {
}

public extension JSONRawRepresentable {
    public typealias JSON = Self.RawValue
    
    public var jsonValue: Self.JSON {
        return self.rawValue
    }
}


/**
 *  This protocol defines high level abstraction for deserializing objects from JSON
 */
public protocol Map {
	subscript(key: String) -> Self { get }
    func value<T>() -> T?

    func <-> <T>(inout left: T, right: Self)
	func <-> <T>(inout left: T?, right: Self)
    func <-> <T>(inout left: T!, right: Self)

    func <-> <T: Mappable>(inout left: T, right: (Self, (inout T, Self) -> Void))

    func <-> <T : RawRepresentable>(inout left: T, right: Self)
    func <-> <T : RawRepresentable>(inout left: T?, right: Self)
    func <-> <T : RawRepresentable>(inout left: T!, right: Self)
    
    //    /// Object of Basic type with Transform
    //    public func <-<T, Transform : TransformType where Transform.Object == T>(inout left: T, right: (Map, Transform)) -> <<error type>>
    //    /// Optional object of basic type with Transform
    //    public func <-<T, Transform : TransformType where Transform.Object == T>(inout left: T?, right: (Map, Transform)) -> <<error type>>
    //    /// Implicitly unwrapped optional object of basic type with Transform
    //    public func <-<T, Transform : TransformType where Transform.Object == T>(inout left: T!, right: (Map, Transform)) -> <<error type>>
}

/**
 *  Defines object that could be mapped to/from JSON
 */
public protocol Mappable: JSONConvertable {
	init?<T:Map>(_ map: T)
}

/**
 *  Root class for mapping
 */
public class Mapping<N: Mappable, T: Map> {
	public typealias MappingFunction = (inout N, T) -> Void
	let mapFunction: MappingFunction

	required public init(mapFunction:  MappingFunction) {
		self.mapFunction = mapFunction
	}

}