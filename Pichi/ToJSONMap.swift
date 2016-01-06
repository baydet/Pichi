//
//  ToJSONMap.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public final class ToJSONMap: Map {
    
    var json: AnyObject? = [:]
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
        return json as? T
    }
    
    private func setValue(value: AnyObject?) {
        defer {
            if let parent = parent {
                parent.setValue(json)
            }
        }
        if var json = json as? [String : AnyObject]  {
            if let key = key where !key.isEmpty {
                json[key] = value
                self.json = json
                return
            } else if let dictionary = value as? [String : AnyObject] {
                dictionary.forEach {
                    json[$0] = $1
                }
                self.json = json
                return
            }
        }
        if let array = value as? [AnyObject] {
            self.json = array
        }
    }
}

public func <-> <T: JSONBasicConvertable>(inout left: T, right: ToJSONMap) {
    right.setValue(left.jsonValue as? AnyObject)
}

public func <-> <T: JSONBasicConvertable>(inout left: T?, right: ToJSONMap) {
    if let field = left {
        right.setValue(field.jsonValue as? AnyObject)
    }
}

public func <-> <T: JSONBasicConvertable>(inout left: T!, right: ToJSONMap) {
    right.setValue(left.jsonValue as? AnyObject)
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T, right: (ToJSONMap, Transform)) {
    right.0.setValue(right.1.transformToJSON(left) as? AnyObject)
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T?, right: (ToJSONMap, Transform)) {
    right.0.setValue(right.1.transformToJSON(left) as? AnyObject)
}

public func <-> <T, Transform: TransformType where Transform.Object == T>(inout left: T!, right: (ToJSONMap, Transform)) {
    right.0.setValue(right.1.transformToJSON(left) as? AnyObject)
}
