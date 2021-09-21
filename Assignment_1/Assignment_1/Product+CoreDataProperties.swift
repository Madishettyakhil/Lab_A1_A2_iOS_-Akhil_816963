//
//  Product+CoreDataProperties.swift
//
//
//  Created by Akhil Madishetty on 19/09/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var prodID: Int64
    @NSManaged public var prodName: String?
    @NSManaged public var prodDesc: String?
    @NSManaged public var prodPrice: String?
    @NSManaged public var prodProvider: String?

}

extension Product : Identifiable {

}
