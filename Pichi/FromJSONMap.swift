//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public struct FromJSONMap: Map {
    
    private let json: [String : AnyObject]
    
    public init(_ json: AnyObject?) {
        if let json = json as? [String : AnyObject] {
            self.json = json
        } else {
            self.json = [:]
        }
        currentValue = json
    }
    
    public let currentValue: AnyObject?
    
    public func value<T>() -> T? {
        return currentValue as? T
    }
    
    public subscript(key: String) -> FromJSONMap {
        return FromJSONMap(valueFor(key))
    }
    
    private func valueFor(key: String) -> AnyObject? {
        if key.isEmpty {
            return nil
        }
        
        let object = json[key]
        if object is NSNull {
            return nil
        }
        return object
    }
}

/// Fetch value from JSON dictionary, loop through keyPathComponents until we reach the desired object


public func <-> <T>(inout left: T?, right: FromJSONMap) {
    optionalBasicType(&left, object: right.value())
}

public func <-> <T>(inout left: T!, right: FromJSONMap) {
    optionalBasicType(&left, object: right.value())
}

public func <-> <T>(inout left: T, right: FromJSONMap) {
    basicType(&left, object: right.value())
}

func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
    if let value = object {
        field = value
    }
}

func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
    if let value = object {
        field = value
    }
}

func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
    if let value = object {
        field = value
    }
}

