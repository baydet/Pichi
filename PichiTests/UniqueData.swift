//
//  UniqueData.swift
//  Cingulata
//
//  Created by Alexander Evsyuchenya on 12/16/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import Foundation
import CoreData
import Pichi


class UniqueData: NSManagedObject, CoreDataMappable {
    
    convenience required init<T:Map>(_ map: T) throws {
        throw NSError(domain: "com.baydet.pichi", code: 0, userInfo: [NSLocalizedDescriptionKey : "unable to init NSManagedObject with init(_ map: T)"])
    }
    
    static func identificationAttributes() -> [UniqueAttribute] {
        return [UniqueAttribute(key: "identifier")]
    }
    
}
