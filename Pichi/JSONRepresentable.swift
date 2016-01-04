//
//  MappingOperators.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public protocol JSONBasicConvertable {
    typealias JSON
    var jsonValue: JSON { get }
    init?(jsonObject: Any)
}

extension JSONBasicConvertable {
    public init?(jsonObject: Any) {
        if let value = jsonObject as? Self {
            self = value
            return
        }
        return nil
    }
}

extension String: JSONBasicConvertable {
    public typealias JSON = String
    
    public var jsonValue: JSON {
        return self
    }
}

extension Int: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return self
    }
}

extension Float: JSONBasicConvertable {
    public typealias JSON = Float
    
    public var jsonValue: JSON {
        return self
    }
}

extension Double: JSONBasicConvertable {
    public typealias JSON = Double
    
    public var jsonValue: JSON {
        return self
    }
}

extension Int64: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int32: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int16: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int8: JSONBasicConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Bool: JSONBasicConvertable {
    public typealias JSON = Bool
    
    public var jsonValue: JSON {
        return self
    }
}

extension CollectionType where Generator.Element: JSONBasicConvertable {
    public typealias JSON = [Generator.Element.JSON]
    
    public var jsonValue: JSON {
        return self.map {
            $0.jsonValue
        }
    }
    
    public init?(jsonObject: Any) {
        if let objects = jsonObject as? [AnyObject] {
            let a = objects.flatMap { (value) -> Generator.Element? in
                return Generator.Element(jsonObject: value)
            }
            print(a)
        }
        return nil
    }
}

extension Array where Element: JSONBasicConvertable {   
    public init?(jsonObject: Any) {
        print(jsonObject)
        if let objects = jsonObject as? [AnyObject] {
            self = objects.flatMap {
                return Element(jsonObject: $0)
            }
            return
        }
        return nil
    }
}