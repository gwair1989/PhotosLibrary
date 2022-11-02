//
//  DataFetcherService.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import Foundation

protocol DataServiseProtocol {
    func fetchPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void)
    func fetchSearchPhotos(searchTerm: String, completion: @escaping (PhotoModel?) -> Void)
}

class DataFetcherService: DataServiseProtocol {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchSearchPhotos(searchTerm: String, completion: @escaping (PhotoModel?) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?query=\(searchTerm)&page=1&per_page=30"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    func fetchPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void) {
        let urlString = "https://api.unsplash.com/photos?page=1&per_page=20"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
}

