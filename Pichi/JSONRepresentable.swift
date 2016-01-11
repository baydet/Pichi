//
//  MappingOperators.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public extension JSONBasicConvertable {
    init?(jsonObject: Any) {
        if let value = jsonObject as? JSON {
            self.init(value)
            return
        }
        return nil
    }
}

public extension JSONBasicConvertable where JSON == Self {
    var jsonValue: JSON {
        return self
    }
}

extension String: JSONBasicConvertable {
    public typealias JSON = String
}

extension Int: JSONBasicConvertable {
    public typealias JSON = Int
}

extension Float: JSONBasicConvertable {
    public typealias JSON = Float
}

extension Bool: JSONBasicConvertable {
    public typealias JSON = Bool
}

extension Double: JSONBasicConvertable {
    public typealias JSON = Float
    
    public var jsonValue: JSON {
        return JSON(self)
    }
}

extension Int64: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return JSON(self)
    }
}

extension Int32: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return JSON(self)
    }
}

extension Int16: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return JSON(self)
    }
}

extension Int8: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return JSON(self)
    }
}