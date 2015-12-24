//
//  MappingOperators.swift
//  Pichi
//
//  Created by Alexandr Evsyuchenya on 12/19/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

public protocol JSONConvertable {
    typealias JSON
    var jsonValue: JSON { get }
    init?(jsonObject: Any)
}

extension JSONConvertable {
    public init?(jsonObject: Any) {
        if let value = jsonObject as? Self {
            self = value
            return
        }
        return nil
    }
}

extension String: JSONConvertable {
    public typealias JSON = String
    
    public var jsonValue: JSON {
        return self
    }
}

extension Int: JSONConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return self
    }
}

extension Float: JSONConvertable {
    public typealias JSON = Float
    
    public var jsonValue: JSON {
        return self
    }
}

extension Double: JSONConvertable {
    public typealias JSON = Double
    
    public var jsonValue: JSON {
        return self
    }
}

extension Int64: JSONConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int32: JSONConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int16: JSONConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Int8: JSONConvertable {
    public typealias JSON = Int
    
    public var jsonValue: JSON {
        return Int(self)
    }
}

extension Bool: JSONConvertable {
    public typealias JSON = Bool
    
    public var jsonValue: JSON {
        return self
    }
}

extension CollectionType where Generator.Element: JSONConvertable {
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

extension Array where Element: JSONConvertable {   
    public init?(jsonObject: Any) {
        if let objects = jsonObject as? [AnyObject] {
            self = objects.flatMap {
                guard let jsonRepresentable = $0 as? Element.Type else {
                    return nil
                }
                return Element(jsonObject: jsonRepresentable)
            }
            return
        }
        return nil
    }
}