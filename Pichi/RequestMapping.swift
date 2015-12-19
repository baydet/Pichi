//
//  RequestMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public final class RequestMapper<N:Mappable>: Mapping<N, ToJSONMap> {

    required public init(mapFunction: MappingFunction) {
        super.init(mapFunction: mapFunction)
    }

    public func map(var object: N) -> [String : AnyObject]? {
        let mapping = ToJSONMap()
        self.mapFunction(&object, mapping)
        return mapping.value()
    }
    
    public func map(objects: [N]) -> [[String : AnyObject]]? {
        return objects.flatMap {
            map($0)
        }
    }
}

/// For RequestOperation usage
extension RequestMapper {
    public func map(object: AnyObject?) -> AnyObject? {
        if let object = object as? N {
            return map(object)
        } else if let objects = object as? [N] {
            return map(objects)
        }
        return nil
    }
}
