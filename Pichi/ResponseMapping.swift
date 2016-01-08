//
//  ResponseMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public class ResponseMapping<N:Mappable>: DictionaryMapping {
    
    public typealias MappingFunction = (inout Object, FromJSONMap) -> Void
    public typealias Object = N
    public typealias JSON = [String : AnyObject]
    
    required public init(mapFunction: MappingFunction) {
        self.mapFunction = mapFunction
    }
    
    public let mapFunction: MappingFunction
    
    internal func createObject(map: FromJSONMap) -> Object? {
        return try? N(map)
    }
    
    public func transformFromJSON(value: JSON?) -> Object? {
        guard let json = value else {
            return nil
        }
        let fromJSONMap = FromJSONMap(json)
        guard var object = createObject(fromJSONMap) else {
            return nil
        }
        self.mapFunction(&object, fromJSONMap)
        return object
    }
}
