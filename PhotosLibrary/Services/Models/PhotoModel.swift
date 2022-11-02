//
//  PhotoModel.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import Foundation

struct PhotoModel: Decodable {
    let results: [UnsplashPhoto]
}

// MARK: - UnsplashPhoto

struct UnsplashPhoto: Decodable {
    let id: String
    var createdAt: String
    let width, height: Int
    let likes: Int
    let urls: [URLKing.RawValue:String]
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height
        case likes
        case urls
        case user
    }
    
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

// MARK: - User
struct User: Codable {
    let name: String
    let profileImage: [ProfileImage.RawValue:String]
    
    enum CodingKeys: String, CodingKey {
            case name
            case profileImage = "profile_image"
        }
    
    enum ProfileImage: String {
        case small
        case medium
        case large

    }
    
}
