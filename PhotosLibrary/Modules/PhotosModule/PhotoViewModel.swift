//
//  PhotoViewModel.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import Foundation

protocol PhotoViewModelProtocol {
    var photoModel: Dynamic<PhotoModel?> { get set }
    func fetchPhotos(searchTerm: String)
    func initialFetchPhotos()
}

final class PhotoViewModel: PhotoViewModelProtocol {
    var photoModel: Dynamic<PhotoModel?> = Dynamic(nil)
    let dataService: DataServiseProtocol
    
    init(dataService: DataServiseProtocol = DataFetcherService()) {
        self.dataService = dataService
    }
    
    func fetchPhotos(searchTerm: String) {
        dataService.fetchSearchPhotos(searchTerm: searchTerm) { [weak self] photos in
            guard let self = self else { return }
            guard let photos = photos else { return }
            let replacementedDateFotos = self.replacementDate(retults: photos.results)
            self.photoModel.value = PhotoModel(results: replacementedDateFotos)
        }
    }
    
    func initialFetchPhotos() {
        dataService.fetchPhotos() { [weak self] photos in
            guard let self = self else { return }
            guard let photos = photos else { return }
            let replacementedDateFotos = self.replacementDate(retults: photos)
            let photoModel = PhotoModel(results: replacementedDateFotos)
            self.photoModel.value = photoModel
        }
    }
    
    private func replacementDate(retults: [UnsplashPhoto]) -> [UnsplashPhoto] {
        var photos = [UnsplashPhoto]()
        for i in retults {
            photos.append(UnsplashPhoto(id: i.id,
                                        createdAt: dateFormate(date: i.createdAt),
                                        width: i.width,
                                        height: i.height,
                                        likes: i.likes,
                                        urls: i.urls,
                                        user: i.user))
        }
        return photos
    }
    
    private func dateFormate(date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: date) {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MMMM dd, yyyy"
            let dateCreate = dateFormat.string(from: date)
            return dateCreate
        }
        return ""
    }
    
}
