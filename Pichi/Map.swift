//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

infix operator <-> {}

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
}

/**
 *  Defines object that could be mapped to/from JSON
 */
public protocol Mappable {
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