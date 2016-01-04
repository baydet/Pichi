//
//  ManagedResponseMapping.swift
//  Pichi
//
//  Created by Alexander Evsyuchenya on 12/18/15.
//  Copyright © 2015 Alexander Evsyuchenya. All rights reserved.
//

import CoreData

extension Mappable where Self: NSManagedObject {
    init<T:Map>(_ map: T) throws {
        throw NSError(domain: "com.baydet.pichi", code: 0, userInfo: [NSLocalizedDescriptionKey : "unable to init NSManagedObject with init(_ map: T)"])
    }
}


public class ManagedResponseMapping<N: NSManagedObject where N:Mappable>: ResponseMapping<N> {

}
