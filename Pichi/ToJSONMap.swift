//
//  ToJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public final class ToJSONMap: Map {
    
    var jsonDictionary: AnyObject = [:]
    private let key: String?
    let parent: ToJSONMap?
    
    public required init() {
        parent = nil
        key = nil
    }
    
    private init(key: String, parent: ToJSONMap) {
        self.key = key
        self.parent = parent
    }
    
    public subscript(key: String) -> ToJSONMap {
        return ToJSONMap(key: key, parent: self)
    }
    
    public func value<T>() -> T? {
        return jsonDictionary as? T
    }
    
    func setValue(value: AnyObject?) {
        if let key = key, var jsonDictionary = jsonDictionary as? [String : AnyObject] where !key.isEmpty {
            jsonDictionary[key] = value
            self.jsonDictionary = jsonDictionary
        }
        if let parent = parent {
            parent.setValue(jsonDictionary)
        }
        if let dictionary = value as? [String : AnyObject], var jsonDictionary = jsonDictionary as? [String : AnyObject] {
            dictionary.forEach {
                jsonDictionary[$0] = $1
            }
            self.jsonDictionary = jsonDictionary
        } else if let array = value as? [AnyObject] {
            self.jsonDictionary = array
        }
    }
}

public func <-> <T: JSONBasicConvertable>(inout left: T, right: ToJSONMap) {
    basicType(left, map: right)
}

public func <-> <T: JSONBasicConvertable>(inout left: T?, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

public func <-> <T: JSONBasicConvertable>(inout left: T!, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

public func <-> <T: JSONBasicConvertable>(inout left: [T], right: ToJSONMap) {
    right.setValue(left.jsonValue as? AnyObject)
}

public func <-> <T: JSONBasicConvertable>(inout left: [T]?, right: ToJSONMap) {
    right.setValue(left?.jsonValue as? AnyObject)
}

public func <-> <T: JSONBasicConvertable>(inout left: [T]!, right: ToJSONMap) {
    right.setValue(left.jsonValue as? AnyObject)
}

public func <-> <T: Mappable>(inout left: T, right: (ToJSONMap, (inout T, ToJSONMap) -> Void)) {
    right.1(&left, right.0)
}

public func <-> <T: Mappable>(inout left: T?, right: (ToJSONMap, (inout T, ToJSONMap) -> Void)) {
    guard var a = left else {
        return
    }
    right.1(&a, right.0)
}

public func <-> <T: Mappable>(inout left: T!, right: (ToJSONMap, (inout T, ToJSONMap) -> Void)) {
    right.1(&left!, right.0)
}

func basicType<N: JSONBasicConvertable>(field: N, map: ToJSONMap) {
    map.setValue(field.jsonValue as? AnyObject)
}

func optionalBasicType<N: JSONBasicConvertable>(field: N?, map: ToJSONMap) {
    if let field = field {
        basicType(field, map: map)
    }
}
