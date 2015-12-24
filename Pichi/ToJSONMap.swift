//
//  ToJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public final class ToJSONMap: Map {
    
    var jsonDictionary: [String : AnyObject] = [:]
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
        if let key = key where !key.isEmpty {
            jsonDictionary[key] = value
        }
        if let parent = parent {
            parent.setValue(jsonDictionary)
        }
        if let dictionary = value as? [String : AnyObject] {
            dictionary.forEach {
                jsonDictionary[$0] = $1
            }
        }
    }
}

public func <-> <T: JSONConvertable>(inout left: T, right: ToJSONMap) {
    basicType(left, map: right)
}

public func <-> <T: JSONConvertable>(inout left: T?, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

public func <-> <T: JSONConvertable>(inout left: T!, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

public func <-> <T: Mappable>(inout left: T, right: (ToJSONMap, (inout T, ToJSONMap) -> Void)) {
    right.1(&left, right.0)
}

public func <-> <T: CollectionType where T.Generator.Element: JSONConvertable>(inout left: T, right: ToJSONMap) {
}

func basicType<N: JSONConvertable>(field: N, map: ToJSONMap) {
    map.setValue(field.jsonValue as? AnyObject)
}

func optionalBasicType<N: JSONConvertable>(field: N?, map: ToJSONMap) {
    if let field = field {
        basicType(field, map: map)
    }
}
