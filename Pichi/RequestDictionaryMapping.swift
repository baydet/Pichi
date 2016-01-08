//
//  RequestMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public final class RequestDictionaryMapping<N:Mappable>: DictionaryMapping {
    public typealias MappingFunction = (inout Object, ToJSONMap) -> Void
    public typealias Object = N
    public typealias JSON = [String : AnyObject]

    required public init(mapFunction: MappingFunction) {
        self.mapFunction = mapFunction
    }
    
    public let mapFunction: MappingFunction
    
    public func transformToJSON(value: Object?) -> JSON? {
        let map = ToJSONMap()
        guard var object = value else {
            return nil
        }
        self.mapFunction(&object, map)
        return map.value()
    }
}