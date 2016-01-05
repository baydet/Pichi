//
//  CollectionTransforms.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 1/5/16.
//  Copyright © 2016 baydet. All rights reserved.
//

import Foundation

public extension TransformType where Object: CollectionType, Object.Generator.Element: JSONBasicConvertable, JSON == [Object.Generator.Element.JSON] {
    func transformToJSON(value: Object?) -> JSON? {
        return value?.map {
            $0.jsonValue
        }
    }
}

public struct BasicArrayTransform<T: JSONBasicConvertable>: TransformType{
    public typealias Object = [T]
    public typealias JSON = [T.JSON]
    
    public func transformFromJSON(value: AnyObject?) -> Object? {
        return nil
    }
}

public struct BasicSetTransform<T where T: Hashable, T: JSONBasicConvertable>: TransformType{
    public typealias Object = Set<T>
    public typealias JSON = [T.JSON]
    
    public func transformFromJSON(value: AnyObject?) -> Object? {
        return nil
    }
}

