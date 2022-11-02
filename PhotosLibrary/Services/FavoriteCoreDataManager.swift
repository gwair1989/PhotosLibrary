//
//  FavoriteCoreDataManager.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 01.11.2022.
//

import Foundation
import CoreData

protocol FavoriteCoreDataManagerProtocol {
    func fetch() -> [FavouritePhoto]
    func delete(id: String)
    func save(photo: FavoritePhotos)
}

class FavoriteCoreDataManager: FavoriteCoreDataManagerProtocol {
    func fetch() -> [FavouritePhoto] {
        let request = FavouritePhoto.fetchRequest()
        let favouritePhoto = CoreDataManager.shared.fetch(request: request)
        return favouritePhoto
    }
    
    func delete(id: String) {
        let request = FavouritePhoto.fetchRequest(id: id)
        CoreDataManager.shared.delete(request: request)
    }
    
    func save(photo: FavoritePhotos) {
        let favouritePhoto = fetch()
        guard favouritePhoto.contains(where: { $0.id == photo.id }) == false else { return }
        
        let context = CoreDataManager.shared.context
        guard let description = NSEntityDescription.entity(
            forEntityName: "FavouritePhoto",
            in: context
        ) else { return }
        
        let photoObject = FavouritePhoto(entity: description, insertInto: context)
        photoObject.id = photo.id
        photoObject.name = photo.name
        photoObject.createdAt = photo.createdAt
        photoObject.height = photo.height
        photoObject.width = photo.width
        photoObject.mainImage = photo.mainImage
        photoObject.likes = photo.likes
        photoObject.profileImage = photo.profileImage
        
        CoreDataManager.shared.saveContext()
        
    }
}
