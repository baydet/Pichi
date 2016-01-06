//
//  FromJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public struct FromJSONMap: Map {
    
    private let json: AnyObject
    
    public init(_ json: AnyObject?) {
        if let json = json {
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

public func <-> <T: JSONBasicConvertable>(inout left: T?, right: FromJSONMap) {
    guard let value: AnyObject = right.value() else {
        return
    }
    left = T(jsonObject: value)
}

public func <-> <T: JSONBasicConvertable>(inout left: T!, right: FromJSONMap) {
    if let value: AnyObject = right.value(), a = T(jsonObject: value) {
        left = a
    }
}

public func <-> <T: JSONBasicConvertable>(inout left: T, right: FromJSONMap) {
    if let value: AnyObject = right.value(), a = T(jsonObject: value) {
        left = a
    }
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T, right: (FromJSONMap, Transform)) {
    if let a = right.1.transformFromJSON(right.0.currentValue) {
        left = a
    }
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T?, right: (FromJSONMap, Transform) ) {
    if let a = right.1.transformFromJSON(right.0.currentValue) {
        left = a
    }
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T!, right: (FromJSONMap, Transform)) {
    if let a = right.1.transformFromJSON(right.0.currentValue) {
        left = a
    }
}
