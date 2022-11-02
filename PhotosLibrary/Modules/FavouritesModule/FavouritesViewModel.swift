//
//  FavouritesViewModel.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 01.11.2022.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var photoModel: Dynamic<[FavoritePhotos]?> { get set }
    func getFavouritePhotos()
}


class FavouritesViewModel: FavouritesViewModelProtocol {
    
    var photoModel: Dynamic<[FavoritePhotos]?> = Dynamic(nil)
    let favoriteCoreDataManager: FavoriteCoreDataManagerProtocol!
    
    init(favoriteCoreDataManager: FavoriteCoreDataManagerProtocol = FavoriteCoreDataManager()) {
        self.favoriteCoreDataManager = favoriteCoreDataManager
    }
    
    func getFavouritePhotos() {
        var favoritePhotos = [FavoritePhotos]()
        let resultDB = favoriteCoreDataManager.fetch()
        
        if !resultDB.isEmpty {
            for photo in resultDB {
                let favoritePhoto = FavoritePhotos(name: photo.name, createdAt: photo.createdAt,
                                                   height: photo.height,
                                                   id: photo.id,
                                                   likes: photo.likes,
                                                   mainImage: photo.mainImage,
                                                   profileImage: photo.profileImage,
                                                   width: photo.width)
                favoritePhotos.append(favoritePhoto)
            }
        }
        self.photoModel.value = favoritePhotos
    }
    
    
}
