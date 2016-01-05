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

public func <-> <T: Mappable>(inout left: T, right: (FromJSONMap, Mapping<T, FromJSONMap>)) {
    
}

public func <-> <T: Mappable>(inout left: T!, right: (FromJSONMap, Mapping<T, FromJSONMap>)) {
    
}

public func <-> <T: Mappable>(inout left: T?, right: (FromJSONMap, Mapping<T, FromJSONMap>)) {
    
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

//if right.0.mappingType == MappingType.FromJSON {
//    let value: T? = right.1.transformFromJSON(right.0.currentValue)
//    FromJSON.optionalBasicType(&left, object: value)
//} else {
//    let value: Transform.JSON? = right.1.transformToJSON(left)
//    ToJSON.optionalBasicType(value, map: right.0)
//}


//public func <-> <T: Mappable>(inout left: T, right: (FromJSONMap, (inout T, FromJSONMap) -> Void)) {
//    right.1(&left, right.0)
//}
//
//public func <-> <T: Mappable>(inout left: T?, right: (FromJSONMap, (inout T, FromJSONMap) -> Void)) {
//    if var a = left {
//        right.1(&a, right.0)
//    } else if var a = try? T(right.0) {
//        right.1(&a, right.0)
//    }
//}
//
//public func <-> <T: Mappable>(inout left: T!, right: (FromJSONMap, (inout T, FromJSONMap) -> Void)) {
//    if var a = left {
//        right.1(&a, right.0)
//    } else if var a = try? T(right.0) {
//        right.1(&a, right.0)
//    }
//}
