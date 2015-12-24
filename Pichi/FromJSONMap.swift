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


public func <-> <T: JSONConvertable>(inout left: T?, right: FromJSONMap) {
    guard let value: AnyObject = right.value() else {
        return
    }
    left = T(jsonObject: value)
}

public func <-> <T: JSONConvertable>(inout left: T!, right: FromJSONMap) {
    guard let value: AnyObject = right.value(), a = T(jsonObject: value) else {
        return
    }
    left = a
}

public func <-> <T: JSONConvertable>(inout left: T, right: FromJSONMap) {
    guard let value: AnyObject = right.value(), a = T(jsonObject: value) else {
        return
    }
    left = a
}

public func <-> <T: Mappable>(inout left: T, right: (FromJSONMap, (inout T, FromJSONMap) -> Void)) {
    right.1(&left, right.0)
}

public func <-> <T: CollectionType where T.Generator.Element: JSONConvertable>(inout left: T, right: FromJSONMap) {
    guard let value: AnyObject = right.value() else {
        return
    }
    let a = T(jsonObject: value)
    left = a ?? left
}

//public func <-> <T: JSONConvertable>(inout left: [T], right: FromJSONMap) {
//    guard let value: AnyObject = right.value(), a = Array<T>(jsonObject: value) else {
//        return
//    }
//    left = a
//}

//public func <-> <T : RawRepresentable>(inout left: T, right: FromJSONMap) {
//    let optRawValue: (T.RawValue)? = right.value()
//    if let raw = optRawValue  {
//        basicType(&left, object: T(rawValue: raw))
//    }
//}
//
//public func <-> <T : RawRepresentable>(inout left: T!, right: FromJSONMap) {
//    let optRawValue: (T.RawValue)? = right.value()
//    if let raw = optRawValue  {
//        optionalBasicType(&left, object: T(rawValue: raw))
//    }
//}
//
//public func <-> <T : RawRepresentable>(inout left: T?, right: FromJSONMap) {
//    let optRawValue: (T.RawValue)? = right.value()
//    if let raw = optRawValue  {
//        optionalBasicType(&left, object: T(rawValue: raw))
//    }
//}

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

