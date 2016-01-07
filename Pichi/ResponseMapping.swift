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
    
    public func transformFromJSON(value: JSON?) -> Object? {
        return nil
    }
}
