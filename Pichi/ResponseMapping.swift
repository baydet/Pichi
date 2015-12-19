//
//  ResponseMapping.swift
//  Cingulata
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public class ResponseMapping<N:Mappable>: Mapping<N, FromJSONMap> {
    
    required public init(mapFunction: MappingFunction) {
        super.init(mapFunction: mapFunction)
    }
    
    public func map(jsonDictionary JSON: [String : AnyObject]) -> N? {
        let map = FromJSONMap(JSON)
        guard var object = N(map) else {
            return nil
        }
        mapFunction(&object, map)
        return object
    }
    
    public func map(jsonArray JSON: [[String : AnyObject]]) -> [N?] {
        return JSON.map {
            return self.map(jsonDictionary: $0)
        }
    }
}

/// For RequestOperation usage
extension ResponseMapping {
    public func map(JSON: AnyObject) -> Any? {
        if let JSON = JSON as? [String : AnyObject] {
            return map(jsonDictionary: JSON)
        } else if let JSON = JSON as? [[String : AnyObject]] {
            return map(jsonArray: JSON)
        }
        return nil
    }
}
