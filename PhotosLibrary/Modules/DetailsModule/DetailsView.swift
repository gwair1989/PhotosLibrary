//
//  DetailsView.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 30.10.2022.
//

import UIKit

class DetailsView: UIView {
    
    private var imageDataTask: URLSessionDataTask?
    
    private static let cache = URLCache(
        memoryCapacity: 50 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        diskPath: "photo"
    )
    
    let imageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.image = UIImage(named: "imageDemo")
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 10
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let bottomView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let avatarImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 16
        obj.backgroundColor = .red
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.font = UIFont(name: "Proxima_nova_regular", size: 18)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let likeButton: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: "like"), for: .normal)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let likesLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "6,870 likes"
        obj.font = UIFont(name: "Proxima_nova_semibold", size: 15)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let dateLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "Published on August 23, 2022"
        obj.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        obj.font = UIFont(name: "Proxima_nova_regular", size: 15)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(photo: UnsplashPhoto) {
        let photoUrl = photo.urls["regular"]
        guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
        
        downloadPhoto(url: url) { [weak self] image, error in
            guard let slf = self, error == nil else { return }
            UIView.transition(
                with: slf.imageView,
                duration: 0.2,
                options: [.transitionCrossDissolve],
                animations: { slf.imageView.image = image },
                completion: nil
            )
        }
        
        likesLabel.text = "\(photo.likes) likes"
        nameLabel.text = photo.user.name
        
        let avatarUrl = photo.user.profileImage["small"]
        guard let avatarUrl = avatarUrl, let urlAvatar = URL(string: avatarUrl) else { return }
        
        downloadPhoto(url: urlAvatar) { [weak self] image, error in
            guard let slf = self, error == nil else { return }
            UIView.transition(
                with: slf.avatarImageView,
                duration: 0.2,
                options: [.transitionCrossDissolve],
                animations: { slf.avatarImageView.image = image },
                completion: nil
            )
        }
        
        dateLabel.text = "Published on \(photo.createdAt)"
    }
    
    
    func config(favoritePhoto: FavoritePhotos) {
        imageView.image = UIImage(data: favoritePhoto.mainImage)
        likesLabel.text = "\(favoritePhoto.likes) likes"
        nameLabel.text = favoritePhoto.name
        avatarImageView.image = UIImage(data: favoritePhoto.profileImage)
        dateLabel.text = "Published on \(favoritePhoto.createdAt)"
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        addSubview(imageView)
        addSubview(bottomView)
        bottomView.addSubview(avatarImageView)
        bottomView.addSubview(nameLabel)
        bottomView.addSubview(likeButton)
        
        addSubview(likesLabel)
        addSubview(dateLabel)
        
        addConstraint()
    }
    
    private func addConstraint() {
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 214)
        ])
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            bottomView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            bottomView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            likeButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 32),
            likeButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            likesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            likesLabel.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dateLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 2)
        ])
        
    }
    
    private func downloadPhoto(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
         if let cachedResponse = DetailsView.cache.cachedResponse(for: URLRequest(url: url)),
             let image = UIImage(data: cachedResponse.data) {
             completion(image, nil)
             return
         }
         
         imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
             self?.imageDataTask = nil
             
             if let error = error {
                 DispatchQueue.main.async { completion(nil, error) }
                 return
             }
             
             guard let data = data, let image = UIImage(data: data), error == nil else { return }
             DispatchQueue.main.async { completion(image, nil) }
         }
         
         imageDataTask?.resume()
         
     }
    
}
