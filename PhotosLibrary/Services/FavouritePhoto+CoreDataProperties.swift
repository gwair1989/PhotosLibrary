//
//  FavouritePhoto+CoreDataProperties.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 01.11.2022.
//
//

import Foundation
import CoreData


extension FavouritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePhoto> {
        return NSFetchRequest<FavouritePhoto>(entityName: "FavouritePhoto")
    }
    
    @nonobjc public class func fetchRequest(id: String) -> NSFetchRequest<FavouritePhoto> {
        let request = fetchRequest()
        let symbolPredicate = NSPredicate(format: "id == %@", id)
        
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [symbolPredicate]
        )
        return request
    }

    @NSManaged public var createdAt: String
    @NSManaged public var height: Int16
    @NSManaged public var id: String
    @NSManaged public var likes: Int16
    @NSManaged public var mainImage: Data
    @NSManaged public var name: String
    @NSManaged public var profileImage: Data
    @NSManaged public var width: Int16

}

extension FavouritePhoto : Identifiable {

}
