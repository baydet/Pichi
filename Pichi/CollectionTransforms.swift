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
    
    public init() {
    }
    
    public func transformFromJSON(value: JSON?) -> Object? {
        guard let array = value else {
            return nil
        }
        return array.flatMap {
            T($0)
        }
    }
}

public struct TransformTypeArrayTransform<T: TransformType>: TransformType{
    public typealias Object = [T.Object]
    public typealias JSON = [T.JSON]
    public let transformType: T
    
    public init(_ transform: T) {
        self.transformType = transform
    }
    
    public func transformFromJSON(value: JSON?) -> Object? {
        guard let array = value else {
            return nil
        }
        return array.flatMap {
            self.transformType.transformFromJSON($0)
        }
    }

    public func transformToJSON(value: Object?) -> JSON? {
        return value?.flatMap {
            self.transformType.transformToJSON($0)
        }
    }
}

public struct BasicSetTransform<T where T: Hashable, T: JSONBasicConvertable>: TransformType{
    public typealias Object = Set<T>
    public typealias JSON = [T.JSON]

    public init() {
    }
    
    public func transformFromJSON(value: JSON?) -> Object? {
        guard let objects = BasicArrayTransform<T>().transformFromJSON(value) else {
            return nil
        }
        return Set<T>(objects)
    }
}