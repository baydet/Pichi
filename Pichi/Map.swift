//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

infix operator <-> {}

public protocol JSONBasicConvertable {
    associatedtype JSON
    var jsonValue: JSON { get }
    init?(jsonObject: Any)
    init?(_: JSON)
}

public protocol TransformType {
    associatedtype Object
    associatedtype JSON
    
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
