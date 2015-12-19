//
//  FromJSONMap.swift
//  Cingulata
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 baydet. All rights reserved.
//

infix operator <-> {}

/**
 *  This protocol defines high level abstraction for deserializing objects from JSON
 */
public protocol nMap {
	subscript(key: String) -> Self { get }
    func value<T>() -> T?

    func <-> <T>(inout left: T, right: Self)
	func <-> <T>(inout left: T?, right: Self)
    func <-> <T>(inout left: T!, right: Self)
}

/**
 *  Defines object that could be mapped to/from JSON
 */
public protocol nMappable {
	init?<T: nMap>(_ map: T)
}

/**
 *  Root class for mapping
 */
public class Mapping<N: nMappable, T: nMap> {
	public typealias MappingFunction = (inout N, T) -> Void
	let mapFunction: MappingFunction

	required public init(mapFunction:  MappingFunction) {
		self.mapFunction = mapFunction
	}

}