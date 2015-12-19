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

public func <-> <T>(inout left: T, right: ToJSONMap) {
    basicType(left, map: right)
}

public func <-> <T>(inout left: T?, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

public func <-> <T>(inout left: T!, right: ToJSONMap) {
    optionalBasicType(left, map: right)
}

//func setValue:

func basicType<N>(field: N, map: ToJSONMap) {
    
    func _setValue(value: AnyObject) {
        map.setValue(value)
    }
    
    if let x = field as? NSNumber { // basic types
        _setValue(x)
    } else if let x = field as? Bool {
        _setValue(x)
    } else if let x = field as? Int {
        _setValue(x)
    } else if let x = field as? Double {
        _setValue(x)
    } else if let x = field as? Float {
        _setValue(x)
    } else if let x = field as? String {
        _setValue(x)
    } else if let x = field as? Array<NSNumber> { // Arrays
        _setValue(x)
    } else if let x = field as? Array<Bool> {
        _setValue(x)
    } else if let x = field as? Array<Int> {
        _setValue(x)
    } else if let x = field as? Array<Double> {
        _setValue(x)
    } else if let x = field as? Array<Float> {
        _setValue(x)
    } else if let x = field as? Array<String> {
        _setValue(x)
    } else if let x = field as? Array<AnyObject> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, NSNumber> { // Dictionaries
        _setValue(x)
    } else if let x = field as? Dictionary<String, Bool> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, Int> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, Double> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, Float> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, String> {
        _setValue(x)
    } else if let x = field as? Dictionary<String, AnyObject> {
        _setValue(x)
    }
}

func optionalBasicType<N>(field: N?, map: ToJSONMap) {
    if let field = field {
        basicType(field, map: map)
    }
}