//
//  DetailsViewModel.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 01.11.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    func addInFovourites(photo: FavoritePhotos)
    func remove(id: String)
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    let favoriteCoreDataManager: FavoriteCoreDataManagerProtocol!
    
    init(favoriteCoreDataManager: FavoriteCoreDataManagerProtocol = FavoriteCoreDataManager()) {
        self.favoriteCoreDataManager = favoriteCoreDataManager
    }
    
    func addInFovourites(photo: FavoritePhotos) {
        favoriteCoreDataManager.save(photo: photo)
    }
    
    func remove(id: String) {
        favoriteCoreDataManager.delete(id: id)
    }
    
}
